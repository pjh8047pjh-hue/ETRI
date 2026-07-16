`ifndef BFM_AXI_TASKS_V
`define BFM_AXI_TASKS_V
//----------------------------------------------------------------
//  Copyright (c) 2013-2017 by Ando Ki.
//  All right reserved.
//  http://www.future-ds.com
//  All rights are reserved by Ando Ki.
//  Do not use in any means or/and methods without Ando Ki's permission.
//----------------------------------------------------------------
// bfm_axi_tasks.sv
//----------------------------------------------------------------
// VERSION: 2013.02.03.
//---------------------------------------------------------
reg [7:0] dataWB[0:1023];
reg [7:0] dataRB[0:1023];
wire [31:0] dataRW[0:15];
//----------------------------------------------------------------
generate
genvar idx;
for (idx=0; idx<16; idx=idx+1) begin : BLK_XXY
     assign dataRW[idx] = {dataRB[idx*4+3], dataRB[idx*4+2], dataRB[idx*4+1], dataRB[idx*4]};
end
endgenerate
//----------------------------------------------------------------
// Read-After-Write
task test_raw;
     input [31:0] id;
     input [31:0] saddr; // start address
     input [31:0] depth; // size in byte
     input [31:0] bsize; // burst size in byte
     input [31:0] bleng; // burst length
     reg   [31:0] addr;
     integer      idx, idy, idz, error;
begin
    error = 0;
    addr = saddr;
    for (idy=0; idy<depth; idy=idy+bsize) begin
        for (idx=0; idx<bsize; idx=idx+1) begin
            dataWB[idx] = idy + idx + 1;
        end
//$display($time,,"%m idy=%03d", idy);
        write_task( id //input [31:0]         id;
                  , addr  //addr;
                  , bsize //size; // 1 ~ 128 byte in a beat
                  , bleng //leng; // 1 ~ 16  beats in a burst
                  , 'h1   //type; // burst type (0=fixed, 1=inc, 2=wrap)
                  );
        read_task ( id //input [31:0]         id;
                  , addr  //addr;
                  , bsize //size; // 1 ~ 128 byte in a beat
                  , bleng //leng; // 1 ~ 16  beats in a burst
                  , 'h1   //type; // burst type
                  );
        for (idz=0; idz<bsize; idz=idz+1) begin
             if (dataWB[idz]!=dataRB[idz]) begin
                 error = error + 1;
                 $display($time,,"%m Error A:0x%x D:0x%x, but 0x%x expected",
                                  addr+idz, dataRB[idz], dataWB[idz]);
             end
             `ifdef DEBUG
             else $display($time,,"%m OK A:0x%x D:0x%x", addr+idz, dataRB[idz]);
             `endif
        end
        addr = addr + bsize;
    end
    if (error==0) $display($time,,"%m test_raw from 0x%08x to 0x%08x %03d-size %03d-leng OK", saddr, saddr+depth-1, bsize, bleng);
end
endtask
//----------------------------------------------------------------
// Read-After-Write ALL
task test_raw_all;
     input [31:0] id;
     input [31:0] saddr; // start address
     input [31:0] depth; // size in byte
     input [31:0] bsize; // burst size in byte
     input [31:0] bleng; // burst length
     reg   [31:0] addr;
     integer      idx, idy, idz, error;
begin
    error = 0;
    addr = saddr;
    for (idy=0; idy<depth; idy=idy+bsize) begin
        for (idx=0; idx<bsize; idx=idx+1) begin
            dataWB[idx] = idy + idx + 1;
        end
//$display($time,,"%m idy=%03d", idy);
        write_task( id //input [31:0]         id;
                  , addr  //addr;
                  , bsize //size; // 1 ~ 128 byte in a beat
                  , bleng //leng; // 1 ~ 16  beats in a burst
                  , 'h0   //type; // burst type
                  );
        addr = addr + bsize;
    end
    addr = saddr;
    for (idy=0; idy<depth; idy=idy+bsize) begin
        read_task ( id //input [31:0]         id;
                  , addr  //addr;
                  , bsize //size; // 1 ~ 128 byte in a beat
                  , bleng //leng; // 1 ~ 16  beats in a burst
                  , 'h0   //type; // burst type
                  );
        for (idz=0; idz<bsize; idz=idz+1) begin
             if ((idy+idz+1)!=dataRB[idz]) begin
                 error = error + 1;
                 $display($time,,"%m Error A:0x%x D:0x%x, but 0x%x expected",
                                  addr+idz, dataRB[idz], idy+idz+1);
             end
        end
        addr = addr + bsize;
    end
    if (error==0) $display($time,,"%m test_raw_all from 0x%08x to 0x%08x %03d-size %03d-leng OK", saddr, saddr+depth-1, bsize, bleng);
end
endtask
//----------------------------------------------------------------
// Read-After-Write
task test_raw_burst;
     input [31:0] id;
     input [31:0] saddr; // start address
     input [31:0] depth; // size in byte
     input [31:0] bsize; // burst size in byte
     input [31:0] bleng; // burst length
     reg   [31:0] addr;
     integer      idx, idy, idz, error;
begin
    error = 0;
    addr = saddr;
    for (idy=0; idy<depth; idy=idy+(bsize*bleng)) begin
        for (idx=0; idx<(bsize*bleng); idx=idx+1) begin
            dataWB[idx] = idy + idx + 1;
        end
        write_task( id //input [31:0]         id;
                  , addr  //addr;
                  , bsize //size; // 1 ~ 128 byte in a beat
                  , bleng //leng; // 1 ~ 16  beats in a burst
                  , 'h1   //type; // burst type (0=fixed, 1=inc, 2=wrap)
                  );
        read_task ( id //input [31:0]         id;
                  , addr  //addr;
                  , bsize //size; // 1 ~ 128 byte in a beat
                  , bleng //leng; // 1 ~ 16  beats in a burst
                  , 'h1   //type; // burst type
                  );
        for (idz=0; idz<bsize; idz=idz+1) begin
             if (dataWB[idz]!=dataRB[idz]) begin
                 error = error + 1;
                 $display($time,,"%m Error A:0x%x D:0x%x, but 0x%x expected",
                                  addr+idz, dataRB[idz], dataWB[idz]);
             end
             `ifdef DEBUG
             else $display($time,,"%m OK A:0x%x D:0x%x", addr+idz, dataRB[idz]);
             `endif
        end
        addr = addr + (bsize*bleng);
    end
    if (error==0) $display($time,,"%m test_raw from 0x%08x to 0x%08x %03d-size %03d-leng OK", saddr, saddr+depth-1, bsize, bleng);
end
endtask
//----------------------------------------------------------------
task read_task;
     input [31:0]         id;
     input [WIDTH_AD-1:0] addr;
     input integer        size; // 1 ~ 128 byte in a beat
     input integer        leng; // 1 ~ 16  beats in a burst
     input integer        typeX; // burst type
begin
     fork
     read_address_channel(id,addr,size,leng,typeX);
     read_data_channel(id,addr,size,leng,typeX);
     join
end
endtask
//----------------------------------------------------------------
task read_address_channel;
     input [WIDTH_ID-1:0] id;
     input [WIDTH_AD-1:0] addr;
     input integer        size; // 1 ~ 128 byte in a beat
     input integer        leng; // 1 ~ 16  beats in a burst
     input integer        typeX; // burst type
begin
     @ (posedge aclk);
     m_axi_arid    <= #1 id;
     m_axi_araddr  <= #1 addr;
     m_axi_arlen   <= #1 leng-1;
     m_axi_arlock  <= #1 'b0;
     m_axi_arsize  <= #1 get_size(size);
     m_axi_arburst <= #1  typeX[1:0];
     m_axi_arvalid <= #1 'b1;
     @ (posedge aclk);
     while (m_axi_arready==1'b0) @ (posedge aclk);
     m_axi_arvalid <= #1 'b0;
     @ (negedge aclk);
end
endtask
//----------------------------------------------------------------
task read_data_channel;
     input [WIDTH_ID-1:0] id;
     input [WIDTH_AD-1:0] addr;
     input integer        size; // 1 ~ 128 byte in a beat
     input integer        leng; // 1 ~ 16  beats in a burst
     input integer        typeX; // burst type
     reg   [WIDTH_AD-1:0] naddr;
     reg   [WIDTH_DS-1:0] strb;
     reg   [WIDTH_DA-1:0] maskT;
     reg   [WIDTH_DA-1:0] dataR;
     integer idx, idy, idz;
begin
     idz = 0;
     naddr  = addr;
     @ (posedge aclk);
     m_axi_rready <= #1 1'b1;
     for (idx=0; idx<leng; idx=idx+1) begin
          @ (posedge aclk);
          while (m_axi_rvalid==1'b0) @ (posedge aclk);
          strb = get_strb(naddr, size);
          dataR = m_axi_rdata;
          for (idy=0; idy<WIDTH_DS; idy=idy+1) begin
               //if (strb[idy]) dataRB[naddr-addr+idy] = dataR&8'hFF;
               if (strb[idy]) begin
                   dataRB[idz] = dataR&8'hFF; // justified
                   idz = idz + 1;
               end
               dataR = dataR>>8;
          end
          //for (idy=(WIDTH_DS-1); idy>=0; idy=idy-1) begin
          //     if (strb[idy]) maskT = (maskT<<8)|{8{1'b1}};
          //     else           maskT = (maskT<<8);
          //end
          //dataR[idx] = (dataR[idx]&~maskT)|(RDATA&maskT);
          if (id!=m_axi_rid) begin
             $display($time,,"%m Error id/RID mis-match for read-data-channel", id, m_axi_rid);
          end
          if (idx==leng-1) begin
             if (m_axi_rlast==1'b0) begin
                 $display($time,,"%m Error RLAST expected for read-data-channel");
             end
          end else begin
              @ (negedge aclk);
              naddr = get_next_addr( naddr  // current address
                                   , size  // num of bytes in a beat
                                   , typeX);// type of burst
          end
     end
     m_axi_rready <= #1 'b0;
     @ (negedge aclk);
end
endtask
//----------------------------------------------------------------
task write_task;
     input [WIDTH_ID-1:0] id;
     input [WIDTH_AD-1:0] addr;
     input integer        size; // 1 ~ 128 byte in a beat
     input integer        leng; // 1 ~ 16  beats in a burst
     input integer        typeX; // burst type
begin
     fork
     write_address_channel(id,addr,size,leng,typeX);
     write_data_channel(id,addr,size,leng,typeX);
     write_resp_channel(id);
     join
end
endtask
//----------------------------------------------------------------
task write_address_channel;
     input [WIDTH_ID-1:0] id;
     input [WIDTH_AD-1:0] addr;
     input integer        size; // 1 ~ 128 byte in a beat
     input integer        leng; // 1 ~ 16  beats in a burst
     input integer        typeX; // burst type
begin
     @ (posedge aclk);
     m_axi_awid    <= #1 id;
     m_axi_awaddr  <= #1 addr;
     m_axi_awlen   <= #1 leng-1;
     m_axi_awlock  <= #1 'b0;
     m_axi_awsize  <= #1 get_size(size);
     m_axi_awburst <= #1  typeX[1:0];
     m_axi_awvalid <= #1 'b1;
     @ (posedge aclk);
     while (m_axi_awready==1'b0) @ (posedge aclk);
     m_axi_awvalid <= #1 'b0;
     @ (negedge aclk);
end
endtask
//----------------------------------------------------------------
task write_data_channel;
     input [WIDTH_ID-1:0] id;
     input [WIDTH_AD-1:0] addr;
     input integer        size; // 1 ~ 128 byte in a beat
     input integer        leng; // 1 ~ 16  beats in a burst
     input integer        typeX; // burst type
     reg   [WIDTH_AD-1:0] naddr;
     integer idx;
begin
     naddr  = addr;
     @ (posedge aclk);
     m_axi_wid    <= #1 id;
     m_axi_wvalid <= #1 1'b1;
     for (idx=0; idx<leng; idx=idx+1) begin
          m_axi_wdata <= #1 get_data(addr, naddr, size);
          m_axi_wstrb <= #1 get_strb(naddr, size);
          m_axi_wlast <= #1 (idx==(leng-1));
          naddr <= get_next_addr(naddr, size, typeX);
          @ (posedge aclk);
          while (m_axi_wready==1'b0) @ (posedge aclk);
     end
     m_axi_wlast  <= #1 'b0;
     m_axi_wvalid <= #1 'b0;
     @ (negedge aclk);
end
endtask
//----------------------------------------------------------------
task write_resp_channel;
     input [WIDTH_ID-1:0] id;
begin
     m_axi_bready <= #1 'b1;
     @ (posedge aclk);
     while (m_axi_bvalid==1'b0) @ (posedge aclk);
     if (id!=m_axi_bid) begin
        $display($time,,"%m Error id mis-match for write-resp-channel 0x%x/0x%x", id, m_axi_bid);
     end
     case (m_axi_bresp)
     2'b00: begin
            `ifdef DEBUG
            $display($time,,"%m OK response for write-resp-channel: OKAY");
            `endif
            end
     2'b01: $display($time,,"%m OK response for write-resp-channel: EXOKAY");
     2'b10: $display($time,,"%m Error response for write-resp-channel: SLVERR");
     2'b11: $display($time,,"%m Error response for write-resp-channel: DECERR");
     endcase
     m_axi_bready <= #1 'b0;
     @ (negedge aclk);
end
endtask
//----------------------------------------------------------------
// input: num of bytes
// output: AxSIZE[2:0] code
function [2:0] get_size;
   input [7:0] size;
begin
   case (size)
     1: get_size = 0;
     2: get_size = 1;
     4: get_size = 2;
     8: get_size = 3;
    16: get_size = 4;
    32: get_size = 5;
    64: get_size = 6;
   128: get_size = 7;
   default: get_size = 0;
   endcase
end
endfunction
//----------------------------------------------------------------
function [WIDTH_DS-1:0] get_strb;
    input [WIDTH_AD-1:0] addr;
    input [31:0] size; // num of bytes in a beat
    integer offset;
    reg   [127:0] bit_size;
begin
    offset   = addr%WIDTH_DS;
    case (size)
      1: bit_size = {  1{1'b1}};
      2: bit_size = {  2{1'b1}};
      4: bit_size = {  4{1'b1}};
      8: bit_size = {  8{1'b1}};
     16: bit_size = { 16{1'b1}};
     32: bit_size = { 32{1'b1}};
     64: bit_size = { 64{1'b1}};
    128: bit_size = {128{1'b1}};
    default: bit_size = 0;
    endcase
    get_strb = bit_size<<offset;
end
endfunction
//----------------------------------------------------------------
function [WIDTH_AD-1:0] get_next_addr;
    input [WIDTH_AD-1:0] addr; // current address
    input [31:0] size; // num of bytes in a beat
    input [31:0] typeX; // type of burst
    integer offset;
begin
    case (typeX[1:0])
    2'b00: get_next_addr = addr; // fixed
    2'b01: begin // increment
           offset = addr%WIDTH_DS;
           if ((offset+size)<=WIDTH_DS) begin
               get_next_addr = addr + size;
           end else begin // (offset+size)>nb
               get_next_addr = addr + WIDTH_DS - size;
           end
           end
    2'b10: begin // wrap
           if ((addr%size)!=0) begin
              $display($time,,"%m wrap-burst not aligned");
              get_next_addr = addr;
           end else begin
               offset = addr%WIDTH_DS;
               if ((offset+size)<=WIDTH_DS) begin
                   get_next_addr = addr + size;
               end else begin // (offset+size)>nb
                   get_next_addr = addr + WIDTH_DS - size;
               end
           end
           end
    default: $display($time,,"%m Error un-defined burst-type: %2b", typeX);
    endcase
end
endfunction
//----------------------------------------------------------------
// dataWB[0]   = saddr + 0;
// dataWB[1]   = saddr + 1;
// dataWB[2]   = saddr + 2;
//
function [WIDTH_DA-1:0] get_data;
    input [WIDTH_AD-1:0] saddr; // start address
    input [WIDTH_AD-1:0] addr;  // current address
    input [31:0]         size;
    reg   [ 7:0]         data[0:WIDTH_DS-1];
    integer offset, idx, idy, idz, ids;
begin
    `ifdef RIGOR
    for (idx=0; idx<WIDTH_DS; idx=idx+1) begin
         data[idx] = 'bX;
    end
    `endif
    offset = addr%WIDTH_DS;
    ids = 0;
    for (idx=addr%WIDTH_DS; (idx<WIDTH_DS)&&(ids<size); idx=idx+1) begin
         idz = addr+(idx-offset)-saddr;
         data[idx] = dataWB[idz];
//$display($time,,"%m sa=%04x ad=%04x idx=%03d idz=%03d", saddr, addr, idx, idz);
         ids = ids + 1;
    end
    get_data = 0;
    for (idy=0; idy<WIDTH_DS; idy=idy+1) begin
         get_data = get_data|(data[idy]<<(8*idy));
    end
    //for (idy=WIDTH_DS-1; idy>=0; idy=idy-1) begin
    //     get_data = (get_data<<8)|data[idy];
    //end
end
endfunction
//----------------------------------------------------------------
// Revision History
//
// 2017.06.22: 'test_raw_burst' bug-fixed by Ando Ki.
// 2013.02.03: Started by Ando Ki (adki@future-ds.com)
//----------------------------------------------------------------
`endif
