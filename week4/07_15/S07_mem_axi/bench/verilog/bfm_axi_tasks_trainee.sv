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
             if (dataWB[idz]!==dataRB[idz]) begin
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
             if (((idy+idz+1)&8'hFF)!==dataRB[idz]) begin
                 error = error + 1;
                 $display($time,,"%m Error A:0x%x D:0x%x, but 0x%x expected",
                                  addr+idz, dataRB[idz], (idy+idz+1)&8'hFF);
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
        for (idz=0; idz<(bsize*bleng); idz=idz+1) begin
             if (dataWB[idz]!==dataRB[idz]) begin
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
    if (error==0) $display($time,,"%m test_raw_burst from 0x%08x to 0x%08x %03d-size %03d-leng OK", saddr, saddr+depth-1, bsize, bleng);
end
endtask
//----------------------------------------------------------------
task read_task;
     input [31:0]         id;
     input [WIDTH_AD-1:0] addr;
     input [31:0]         size; // 1 ~ 128 byte in a beat
     input [31:0]         leng; // 1 ~ 16  beats in a burst
     input [31:0]         typeX; // burst type
begin
     fork
     read_address_channel(id,addr,size,leng,typeX);
     read_data_channel(id,addr,size,leng,typeX);
     join
end
endtask
//----------------------------------------------------------------
task read_address_channel;
     input [31:0]         id;
     input [WIDTH_AD-1:0] addr;
     input [31:0]         size; // 1 ~ 128 byte in a beat
     input [31:0]         leng; // 1 ~ 16  beats in a burst
     input [31:0]         typeX; // burst type
begin
     if ((size==0) || (size>WIDTH_DS) || ((size&(size-1))!=0))
         $display($time,,"%m Error invalid read beat size: %0d", size);
     if ((leng==0) || (leng>256))
         $display($time,,"%m Error invalid read burst length: %0d", leng);
     if ((typeX[1:0]==2'b10) &&
         ((leng!=2) && (leng!=4) && (leng!=8) && (leng!=16)))
         $display($time,,"%m Error invalid WRAP read burst length: %0d", leng);
     if ((typeX[1:0]==2'b10) && ((addr%size)!=0))
         $display($time,,"%m Error unaligned WRAP read address: 0x%08x", addr);

     @(posedge aclk);
     m_axi_arid    <= id[WIDTH_ID-1:0];
     m_axi_araddr  <= addr;
     m_axi_arlen   <= leng-1;
     m_axi_arlock  <= 1'b0;
     m_axi_arsize  <= get_size(size);
     m_axi_arburst <= typeX[1:0];
     m_axi_arvalid <= 1'b1;

     // Keep every AR payload signal stable until the handshake edge.
     @(posedge aclk);
     while (m_axi_arready!==1'b1) begin
          @(posedge aclk);
     end
     m_axi_arvalid <= 1'b0;
end
endtask
//----------------------------------------------------------------
task read_data_channel;
     input [31:0]         id;
     input [WIDTH_AD-1:0] addr;
     input [31:0]         size; // 1 ~ 128 byte in a beat
     input [31:0]         leng; // 1 ~ 16  beats in a burst
     input [31:0]         typeX; // burst type
     reg   [WIDTH_AD-1:0] naddr;
     reg   [WIDTH_DS-1:0] strb;
     reg   [WIDTH_DA-1:0] dataR;
     integer idx, idy, idz, buffer_index, byte_index;
begin
     naddr = addr;
     buffer_index = 0;
     @(posedge aclk);
     m_axi_rready <= 1'b1;

     for (idx=0; idx<leng; idx=idx+1) begin
          // RREADY stays asserted, so RVALID at this edge completes a beat.
          @(posedge aclk);
          while (m_axi_rvalid!==1'b1) begin
               @(posedge aclk);
          end

          if (m_axi_rid!==id[WIDTH_ID-1:0])
              $display($time,,"%m Error RID 0x%x, expected 0x%x",
                       m_axi_rid, id[WIDTH_ID-1:0]);
          if (m_axi_rresp!==2'b00)
              $display($time,,"%m Error RRESP 0x%x at address 0x%08x",
                       m_axi_rresp, naddr);
          if (m_axi_rlast!==(idx==(leng-1)))
              $display($time,,"%m Error RLAST %b on beat %0d of %0d",
                       m_axi_rlast, idx+1, leng);

          strb   = get_strb(naddr,size);
          byte_index = 0;
          for (idy=0; idy<WIDTH_DS; idy=idy+1) begin
               if (strb[idy]===1'b1) begin
                    idz = buffer_index+byte_index;
                    if ((idz>=0) && (idz<=1023)) begin
                         dataR = m_axi_rdata>>(8*idy);
                         dataRB[idz] = dataR[7:0];
                    end else begin
                         $display($time,,"%m Error read data buffer overflow at byte %0d", idz);
                    end
                    byte_index = byte_index+1;
               end
          end
          if (typeX[1:0]!=2'b00)
              buffer_index = buffer_index+byte_index;
          naddr = get_next_burst_addr(naddr,size,leng,typeX);
     end
     m_axi_rready <= 1'b0;
end
endtask
//----------------------------------------------------------------
task write_task;
     input [31:0]         id;
     input [WIDTH_AD-1:0] addr;
     input [31:0]         size; // 1 ~ 128 byte in a beat
     input [31:0]         leng; // 1 ~ 16  beats in a burst
     input [31:0]         typeX; // burst type
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
     input [31:0]         id;
     input [WIDTH_AD-1:0] addr;
     input [31:0]         size; // 1 ~ 128 byte in a beat
     input [31:0]         leng; // 1 ~ 16  beats in a burst
     input [31:0]         typeX; // burst type
begin
     if ((size==0) || (size>WIDTH_DS) || ((size&(size-1))!=0))
         $display($time,,"%m Error invalid write beat size: %0d", size);
     if ((leng==0) || (leng>256))
         $display($time,,"%m Error invalid write burst length: %0d", leng);
     if ((typeX[1:0]==2'b10) &&
         ((leng!=2) && (leng!=4) && (leng!=8) && (leng!=16)))
         $display($time,,"%m Error invalid WRAP write burst length: %0d", leng);
     if ((typeX[1:0]==2'b10) && ((addr%size)!=0))
         $display($time,,"%m Error unaligned WRAP write address: 0x%08x", addr);

     @(posedge aclk);
     m_axi_awid    <= id[WIDTH_ID-1:0];
     m_axi_awaddr  <= addr;
     m_axi_awlen   <= leng-1;
     m_axi_awlock  <= 1'b0;
     m_axi_awsize  <= get_size(size);
     m_axi_awburst <= typeX[1:0];
     m_axi_awvalid <= 1'b1;

     // Keep every AW payload signal stable until the handshake edge.
     @(posedge aclk);
     while (m_axi_awready!==1'b1) begin
          @(posedge aclk);
     end
     m_axi_awvalid <= 1'b0;
end
endtask
//----------------------------------------------------------------
task write_data_channel;
     input [31:0]         id;
     input [WIDTH_AD-1:0] addr;
     input [31:0]         size; // 1 ~ 128 byte in a beat
     input [31:0]         leng; // 1 ~ 16  beats in a burst
     input [31:0]         typeX; // burst type
     reg   [WIDTH_AD-1:0] naddr;
     reg   [WIDTH_DS-1:0] strb;
     integer idx, idy, buffer_index, byte_count;
begin
     naddr = addr;
     buffer_index = 0;
     @(posedge aclk);
     m_axi_wid    <= id[WIDTH_ID-1:0];
     m_axi_wvalid <= 1'b1;

     for (idx=0; idx<leng; idx=idx+1) begin
          strb = get_strb(naddr,size);
          m_axi_wdata <= get_indexed_data(buffer_index,naddr,size);
          m_axi_wstrb <= strb;
          m_axi_wlast <= (idx==(leng-1));

          byte_count = 0;
          for (idy=0; idy<WIDTH_DS; idy=idy+1) begin
               if (strb[idy]===1'b1)
                   byte_count = byte_count+1;
          end

          // Hold WDATA/WSTRB/WLAST while the slave applies backpressure.
          @(posedge aclk);
          while (m_axi_wready!==1'b1) begin
               @(posedge aclk);
          end
          if (typeX[1:0]!=2'b00)
              buffer_index = buffer_index+byte_count;
          naddr = get_next_burst_addr(naddr,size,leng,typeX);
     end
     m_axi_wvalid <= 1'b0;
     m_axi_wlast  <= 1'b0;
     m_axi_wstrb  <= {WIDTH_DS{1'b0}};
end
endtask
//----------------------------------------------------------------
task write_resp_channel;
     input [31:0] id;
begin
     // BREADY may be asserted before the slave produces the response.
     @(posedge aclk);
     m_axi_bready <= 1'b1;
     @(posedge aclk);
     while (m_axi_bvalid!==1'b1) begin
          @(posedge aclk);
     end

     if (m_axi_bid!==id[WIDTH_ID-1:0])
         $display($time,,"%m Error BID 0x%x, expected 0x%x",
                  m_axi_bid, id[WIDTH_ID-1:0]);
     if (m_axi_bresp!==2'b00)
         $display($time,,"%m Error BRESP 0x%x", m_axi_bresp);
     m_axi_bready <= 1'b0;
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
    input [31:0] addr;
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
// Backward-compatible helper for one data-bus-width address window.  The
// channel tasks below use get_next_burst_addr(), which also knows AxLEN and
// therefore implements a full AXI WRAP boundary.
function [WIDTH_AD-1:0] get_next_addr;
    input [31:0] addr; // current address
    input [31:0] size; // num of bytes in a beat
    input [31:0] typeX; // type of burst
    reg   [WIDTH_AD-1:0] aligned_addr;
    reg   [WIDTH_AD-1:0] next_addr;
    reg   [WIDTH_AD-1:0] wrap_base;
begin
    case (typeX[1:0])
    2'b00: get_next_addr = addr;
    2'b01: begin
           aligned_addr = (addr/size)*size;
           get_next_addr = aligned_addr+size;
           end
    2'b10: begin
           if ((size==0) || ((addr%size)!=0)) begin
               $display($time,,"%m Error invalid wrap-burst address/size");
               get_next_addr = addr;
           end else begin
               wrap_base = (addr/WIDTH_DS)*WIDTH_DS;
               next_addr = addr+size;
               if (next_addr>=(wrap_base+WIDTH_DS))
                   get_next_addr = wrap_base;
               else
                   get_next_addr = next_addr;
           end
           end
    default: begin
             $display($time,,"%m Error un-defined burst-type: %2b", typeX);
             get_next_addr = addr;
             end
    endcase
end
endfunction
//----------------------------------------------------------------
function [WIDTH_AD-1:0] get_next_burst_addr;
    input [31:0] addr; // current address
    input [31:0] size; // num of bytes in a beat
    input [31:0] leng; // num of beats in a burst
    input [31:0] typeX; // type of burst
    reg   [WIDTH_AD-1:0] aligned_addr;
    reg   [WIDTH_AD-1:0] next_addr;
    reg   [WIDTH_AD-1:0] wrap_base;
    reg   [WIDTH_AD-1:0] wrap_top;
    integer burst_bytes;
begin
    case (typeX[1:0])
    2'b00: get_next_burst_addr = addr; // fixed
    2'b01: begin // increment
           // The first transfer may be unaligned; every following transfer is
           // aligned to the number of bytes encoded by AxSIZE.
           aligned_addr = (addr/size)*size;
           get_next_burst_addr = aligned_addr+size;
           end
    2'b10: begin // wrap
           burst_bytes = size*leng;
           if ((size==0) || (leng==0) || ((addr%size)!=0)) begin
              $display($time,,"%m Error invalid wrap-burst address/size/length");
              get_next_burst_addr = addr;
           end else begin
               wrap_base = (addr/burst_bytes)*burst_bytes;
               wrap_top  = wrap_base+burst_bytes;
               next_addr = addr+size;
               if (next_addr>=wrap_top)
                   get_next_burst_addr = wrap_base;
               else
                   get_next_burst_addr = next_addr;
           end
           end
    default: begin
             $display($time,,"%m Error un-defined burst-type: %2b", typeX);
             get_next_burst_addr = addr;
             end
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
    integer offset, idx, idz, ids;
begin
    `ifdef RIGOR
    get_data = {WIDTH_DA{1'bx}};
    `else
    get_data = {WIDTH_DA{1'b0}};
    `endif
    offset = addr%WIDTH_DS;
    ids = 0;
    for (idx=addr%WIDTH_DS; (idx<WIDTH_DS)&&(ids<size); idx=idx+1) begin
         idz = addr+(idx-offset)-saddr;
         if ((idz>=0) && (idz<=1023)) begin
              get_data[(8*idx)+:8] = dataWB[idz];
         end else begin
              $display($time,,"%m Error write data buffer overflow at byte %0d", idz);
              get_data[(8*idx)+:8] = 8'hxx;
         end
//$display($time,,"%m sa=%04x ad=%04x idx=%03d idz=%03d", saddr, addr, idx, idz);
         ids = ids + 1;
    end
end
endfunction
//----------------------------------------------------------------
// Assemble a write beat from a sequential byte-buffer index.  Keeping the
// buffer position separate from the bus address is required for WRAP bursts,
// whose address can move below the transaction's start address.
function [WIDTH_DA-1:0] get_indexed_data;
    input [31:0]         data_index;
    input [WIDTH_AD-1:0] addr;
    input [31:0]         size;
    integer idx, idz, ids;
begin
    `ifdef RIGOR
    get_indexed_data = {WIDTH_DA{1'bx}};
    `else
    get_indexed_data = {WIDTH_DA{1'b0}};
    `endif
    ids = 0;
    for (idx=addr%WIDTH_DS; (idx<WIDTH_DS)&&(ids<size); idx=idx+1) begin
         idz = data_index+ids;
         if ((idz>=0) && (idz<=1023)) begin
              get_indexed_data[(8*idx)+:8] = dataWB[idz];
         end else begin
              $display($time,,"%m Error write data buffer overflow at byte %0d", idz);
              get_indexed_data[(8*idx)+:8] = 8'hxx;
         end
         ids = ids+1;
    end
end
endfunction
//----------------------------------------------------------------
// Revision History
//
// 2017.06.22: 'test_raw_burst' bug-fixed by Ando Ki.
// 2013.02.03: Started by Ando Ki (adki@future-ds.com)
//----------------------------------------------------------------
`endif
