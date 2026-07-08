<#
Creates one Notion Daily Log page following JH/07_07/S01_ex_APB_memory/DAILY_LOG_GUIDE.md template.
Reads NOTION_TOKEN / NOTION_DAILY_LOG_DB_ID from JH/.env (not committed to git).
#>
param(
    [Parameter(Mandatory=$true)][string]$Date,        # yyyy-MM-dd
    [Parameter(Mandatory=$true)][string]$Topic,
    [string[]]$DidToday      = @(),
    [string[]]$FilesChanged  = @(),
    [string]  $Commands      = "",
    [string[]]$Result        = @(),
    [string[]]$ErrorsFixed   = @(),
    [string[]]$Learned       = @(),
    [string[]]$NextTodo      = @(),
    [string]  $GithubUrl     = "",
    [string[]]$Tags          = @()
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$envFile  = Join-Path $repoRoot ".env"
if (-not (Test-Path $envFile)) { throw "Missing .env at $envFile" }

$envVars = @{}
Get-Content $envFile | ForEach-Object {
    if ($_ -match '^\s*([^#=]+)=(.*)$') {
        $envVars[$matches[1].Trim()] = $matches[2].Trim()
    }
}

$token = $envVars["NOTION_TOKEN"]
$dbId  = $envVars["NOTION_DAILY_LOG_DB_ID"]
if (-not $token -or -not $dbId) { throw "NOTION_TOKEN / NOTION_DAILY_LOG_DB_ID not found in .env" }

$headers = @{
    "Authorization"  = "Bearer $token"
    "Notion-Version" = "2022-06-28"
    "Content-Type"   = "application/json"
}

function New-BulletBlocks([string[]]$Items) {
    if (-not $Items -or $Items.Count -eq 0) { $Items = @("-") }
    return $Items | ForEach-Object {
        @{
            object = "block"
            type   = "bulleted_list_item"
            bulleted_list_item = @{
                rich_text = @(@{ type = "text"; text = @{ content = $_ } })
            }
        }
    }
}

function New-Heading([string]$Text) {
    return @{
        object     = "block"
        type       = "heading_3"
        heading_3  = @{ rich_text = @(@{ type = "text"; text = @{ content = $Text } }) }
    }
}

$children = @()
$children += (New-Heading "한 일")
$children += (New-BulletBlocks $DidToday)
$children += (New-Heading "수정한 파일")
$children += (New-BulletBlocks $FilesChanged)
$children += (New-Heading "실행한 명령")
$children += @{
    object = "block"
    type   = "code"
    code   = @{
        rich_text = @(@{ type = "text"; text = @{ content = ($(if ($Commands) { $Commands } else { "-" })) } })
        language  = "shell"
    }
}
$children += (New-Heading "결과")
$children += (New-BulletBlocks $Result)
$children += (New-Heading "에러 / 해결")
$children += (New-BulletBlocks $ErrorsFixed)
$children += (New-Heading "배운 점")
$children += (New-BulletBlocks $Learned)
$children += (New-Heading "다음 할 일")
$children += (New-BulletBlocks $NextTodo)
$children += (New-Heading "GitHub 링크")
$children += (New-BulletBlocks @($(if ($GithubUrl) { $GithubUrl } else { "-" })))

$properties = @{
    "Name" = @{ title = @(@{ type = "text"; text = @{ content = "$Date $Topic" } }) }
    "Date" = @{ date = @{ start = $Date } }
    "Topic" = @{ rich_text = @(@{ type = "text"; text = @{ content = $Topic } }) }
}
if ($GithubUrl) { $properties["GitHub"] = @{ url = $GithubUrl } }
if ($Tags.Count -gt 0) { $properties["Tags"] = @{ multi_select = @($Tags | ForEach-Object { @{ name = $_ } }) } }

$body = @{
    parent     = @{ database_id = $dbId }
    properties = $properties
    children   = $children
} | ConvertTo-Json -Depth 20

try {
    $page = Invoke-RestMethod -Uri "https://api.notion.com/v1/pages" -Headers $headers -Method Post -Body $body
    Write-Output "Created Notion page: $($page.url)"
} catch {
    $resp = $_.Exception.Response
    $stream = $resp.GetResponseStream()
    $reader = New-Object System.IO.StreamReader($stream)
    Write-Error $reader.ReadToEnd()
}
