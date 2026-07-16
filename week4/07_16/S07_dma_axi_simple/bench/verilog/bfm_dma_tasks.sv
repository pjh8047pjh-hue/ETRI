`ifndef BFM_DMA_TASKS_SV
`define BFM_DMA_TASKS_SV
   //---------------------------------------------------------
   localparam CSRA_NAME0   = 32'h6000_0000 + 8'h00,
              CSRA_NAME1   = 32'h6000_0000 + 8'h04,
              CSRA_NAME2   = 32'h6000_0000 + 8'h08,
              CSRA_NAME3   = 32'h6000_0000 + 8'h0C,
              CSRA_COMP0   = 32'h6000_0000 + 8'h10,
              CSRA_COMP1   = 32'h6000_0000 + 8'h14,
              CSRA_COMP2   = 32'h6000_0000 + 8'h18,
              CSRA_COMP3   = 32'h6000_0000 + 8'h1C,
              CSRA_VERSION = 32'h6000_0000 + 8'h20,
              CSRA_CONTROL = 32'h6000_0000 + 8'h30,
              CSRA_NUM     = 32'h6000_0000 + 8'h40,
              CSRA_SOURCE  = 32'h6000_0000 + 8'h44,
              CSRA_DEST    = 32'h6000_0000 + 8'h48;
   //---------------------------------------------------------
   task csr_test;
   begin
     read_task(3, CSRA_NAME0  , 4, 1, 1); $display($time,,"%m %s A:0x%08X D:0x%08X", "NAME0  ", CSRA_NAME0  , dataRW[0]);
     read_task(3, CSRA_NAME1  , 4, 1, 1); $display($time,,"%m %s A:0x%08X D:0x%08X", "NAME1  ", CSRA_NAME1  , dataRW[0]);
     read_task(3, CSRA_NAME2  , 4, 1, 1); $display($time,,"%m %s A:0x%08X D:0x%08X", "NAME2  ", CSRA_NAME2  , dataRW[0]);
     read_task(3, CSRA_NAME3  , 4, 1, 1); $display($time,,"%m %s A:0x%08X D:0x%08X", "NAME3  ", CSRA_NAME3  , dataRW[0]);
     read_task(3, CSRA_COMP0  , 4, 1, 1); $display($time,,"%m %s A:0x%08X D:0x%08X", "COMP0  ", CSRA_COMP0  , dataRW[0]);
     read_task(3, CSRA_COMP1  , 4, 1, 1); $display($time,,"%m %s A:0x%08X D:0x%08X", "COMP1  ", CSRA_COMP1  , dataRW[0]);
     read_task(3, CSRA_COMP2  , 4, 1, 1); $display($time,,"%m %s A:0x%08X D:0x%08X", "COMP2  ", CSRA_COMP2  , dataRW[0]);
     read_task(3, CSRA_COMP3  , 4, 1, 1); $display($time,,"%m %s A:0x%08X D:0x%08X", "COMP3  ", CSRA_COMP3  , dataRW[0]);
     read_task(3, CSRA_VERSION, 4, 1, 1); $display($time,,"%m %s A:0x%08X D:0x%08X", "VERSION", CSRA_VERSION, dataRW[0]);
     read_task(3, CSRA_CONTROL, 4, 1, 1); $display($time,,"%m %s A:0x%08X D:0x%08X", "CONTROL", CSRA_CONTROL, dataRW[0]);
     read_task(3, CSRA_NUM    , 4, 1, 1); $display($time,,"%m %s A:0x%08X D:0x%08X", "NUM    ", CSRA_NUM    , dataRW[0]);
     read_task(3, CSRA_SOURCE , 4, 1, 1); $display($time,,"%m %s A:0x%08X D:0x%08X", "SOURCE ", CSRA_SOURCE , dataRW[0]);
     read_task(3, CSRA_DEST   , 4, 1, 1); $display($time,,"%m %s A:0x%08X D:0x%08X", "DEST   ", CSRA_DEST   , dataRW[0]);
   end
   endtask
   //---------------------------------------------------------
`define tty99
`ifdef tty99
   // fill, DMA, test
   task one_dma_test;
       input [31:0] src;
       input [31:0] dst;
       input [15:0] bnum;
       input [ 7:0] chunk; // burst size

       reg [31:0] ad, dat, exp;
       reg [ 3:0] be;
       integer err;
       integer seed;
   begin
       if (src%WIDTH_DS!=0 || dst%WIDTH_DS!=0) $display("%m Warning mis-aligned address.");
       if (bnum%WIDTH_DS!=0) $display("%m Warning mis-aligned the num of bytes to move.");
       // pattern write to the source memory
       seed = 9;
       dat = $random(seed);
       for (ad=src; ad<(src+bnum); ad=ad+WIDTH_DS) begin
            top.u_mem.write(ad, dat, {WIDTH_DS{1'b1}});
       end
       // let DMA work
       one_dma(src, dst, bnum, chunk);
       // pattern read from the destination memory
       err=0;
       seed = 9;
       exp = $random(seed);
       for (ad=dst; ad<(dst+bnum); ad=ad+WIDTH_DS) begin
            top.u_mem.read(ad, dat);
            if (dat!=exp) err=err+1; 
       end
       if (err>0) $display($time,,"%m mismatch %d", err);
       else       $display($time,,"%m OK");
   end
   endtask
   //---------------------------------------------------------
   task one_dma;
       input [31:0] src;
       input [31:0] dst;
       input [15:0] bnum;
       input [ 7:0] chunk;

       reg [31:0] value;
   begin
     {dataWB[3],dataWB[2],dataWB[1],dataWB[0]} = 32'h8000_0001; // enable
     value = {dataWB[3],dataWB[2],dataWB[1],dataWB[0]};
     write_task(2, CSRA_CONTROL, 4, 1, 1);
     {dataWB[3],dataWB[2],dataWB[1],dataWB[0]} = src;
     write_task(2, CSRA_SOURCE, 4, 1, 1);
     {dataWB[3],dataWB[2],dataWB[1],dataWB[0]} = dst;
     write_task(2, CSRA_DEST, 4, 1, 1);
     value = bnum | (chunk<<16) | (1<<31);
     {dataWB[3],dataWB[2],dataWB[1],dataWB[0]} = value;
     write_task(2, CSRA_NUM, 4, 1, 1);
     while (value&32'h8000_0000) begin
        read_task(2, CSRA_NUM, 4, 1, 1);
        value = dataRW[0];
     end
   end
   endtask
   //---------------------------------------------------------
`endif // `ifdef tty99
`endif // `ifndef BFM_DMA_TASKS_SV
