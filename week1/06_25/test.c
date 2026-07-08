#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
int main(){
    FILE *fp=fopen("lenna8bit.raw","rb");
    if (fp == NULL) {
        printf("input file open error\n");
        return 1;
    }

    int c=512*512;
    // unsigned char buf[c];
    // fread(buf,sizeof(char),c,fp);
    // fclose (fp);
    char weight[3][3]={{1,0,-1},{1,0,-1},{1,0,-1}};
    // int input[10][10]={{1,2,3,4,5,6,7,8,9,10},{11,12,13,14,15,16,17,18,19,20},{21,22,23,24,25,26,27,28,29,30},{31,32,33,34,35,36,37,38,39,40},{41,42,43,44,45,46,47,48,49,50},{51,52,53,54,55,56,57,58,59,60},{61,62,63,64,65,66,67,68,69,70},{71,72,73,74,75,76,77,78,79,80},{81,82,83,84,85,86,87,88,89,90},{91,92,93,94,95,96,97,98,99,100}};
    // // int output[8][8];
    unsigned char *pI=(unsigned char*)malloc(sizeof(unsigned char)*512*512);
    unsigned char *pO=(unsigned char *)malloc(sizeof(unsigned char)*510*510);
    char *pK =(char *)weight;//=(unsigned char *)malloc(sizeof(char)*9);
    fread(pI,sizeof(char),c,fp);
    fclose (fp);
    // memcpy(pI,buf,sizeof(unsigned char)*512*512);
    memcpy(pK,weight,sizeof(char)*3*3);
    
    int i,j,h,k;
    int sum=0;

    for (j=0;j<510;j++){
        for (i=0;i<510;i++){
        //     if (j==0 && i==0) {output[j][i]=input[j][i]*weight[1][1]+input[j][i+1]*weight[1][2]+input[j+1][i]*weight[2][1]+input[j+1][i+1]*weight[2][2];}
        //     else if (j==0 && i==m) {output[j][i]=input[j][i-1]*weight[1][0]+input[j][i]*weight[1][1]+input[j+1][i-1]*weight[2][0]+input[j+1][i]*weight[2][1];}
        //     else if (j==m && i==0) {input[j-1][i]*weight[0][1]+input[j-1][i+1]*weight[0][2]+input[j][i]*weight[1][1]+input[j][i+1]*weight[1][2];}
        //     else if (j==m && i==m) {input[j-1][i-1]*weight[0][0]+input[j-1][i]*weight[0][1]+input[j][i-1]*weight[1][0]+input[j][i]*weight[1][1];}
        //     else if (i==0) {input[j-1][i]*weight[0][1]+input[j-1][i+1]*weight[0][2]+input[j][i]*weight[1][1]+input[j][i+1]*weight[1][2]+input[j+1][i]*weight[2][1]+input[j+1][i+1]*weight[2][2];}
        //     else if (j==m) {input[j-1][i-1]*weight[0][0]+input[j-1][i]*weight[0][1]+input[j][i-1]*weight[1][0]+input[j][i]*weight[1][1]+input[j+1][i-1]*weight[2][0]+input[j+1][i]*weight[2][1];}
        //     else if (i==0) {input[j][i-1]*weight[1][0]+input[j][i]*weight[1][1]+input[j][i+1]*weight[1][2]+input[j+1][i-1]*weight[2][0]+input[j+1][i]*weight[2][1]+input[j+1][i+1]*weight[2][2];}
        //     else if (i==m) {input[j-1][i-1]*weight[0][0]+input[j-1][i]*weight[0][1]+input[j-1][i+1]*weight[0][2]+input[j][i-1]*weight[1][0]+input[j][i]*weight[1][1]+input[j][i+1]*weight[1][2];}
        //     else{
                for (k=0;k<3;k++){
                    for (h=0;h<3;h++){
                        sum=sum+pI[512*(j+k)+i+h]*pK[3*k+h];
                        
                    }
                }
                if (abs(sum)>40) {
                            *(pO+j*510+i)=255;
                }
                else{*(pO+j*510+i)=0;}
                // output[j][i]=sum;
                sum=0;
                
            // }
        }
        
    }
    
    
    // for(a=0;a<8;a++){
    //     for (b=0;b<8;b++){
    //         *(pO+a*10+b)=output[a][b];
    //     }
    // }
    // memcpy(pO,output,sizeof(output));
    printf("%d\n",pO[56]);
    
    FILE *fo=fopen("output_file.raw","wb");
    int d=510*510;
    unsigned char buffer[d];
    memcpy(buffer,pO,sizeof(unsigned char)*510*510);
    fwrite(buffer,sizeof(char),d,fo);
    fclose(fo);
    
    
free(pI);
free(pO);

}
