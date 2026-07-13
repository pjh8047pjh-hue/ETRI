
task axi_lite_write;
      input integer addr;
      input integer data;
   begin
      //                __    __    __    __    __    __    __    __
      //  aclk       __|  |__|  |__|  |__|  |__|  |__|  |__|  |__|  |
      //                ________   |     |
      //  awaddr[]   XXX________   |     |
      //                ______     |     |
      //  awvalid    __/      \    |     |
      //             ____________  |     |
      //  awready    __/      \___ |     |
      //                           |     |
      //                ________   |     |
      //   wdata[]   XXX________   |     |
      //                ______     |     |
      //   wvalid    __/      \    |     |
      //             ____________  |     |
      //   wready    __/      \___ |     |
      //                           |     |
      //                           |_____|__
      //   bresp[]               XXX________
      //                            ______
      //   bvalid                __/      \__
      //              ________________________
      //   bready     _/                  \___

      @(posedge aclk);
      m_axi_lite_awaddr  <= #1 addr;
      m_axi_lite_awvalid <= #1 1'b1;
      m_axi_lite_wdata   <= #1 data;
      m_axi_lite_wvalid  <= #1 1'b1;
      m_axi_lite_bready  <= #1 1'b1;

      repeat(2) @(posedge aclk);

      @(posedge aclk);
      m_axi_lite_awaddr  <= #1 0;
      m_axi_lite_awvalid <= #1 1'b0;
      m_axi_lite_wdata   <= #1 32'd0;
      m_axi_lite_wvalid  <= #1 1'b0;
      m_axi_lite_bready  <= #1 1'b0;
   end
endtask

task axi_lite_read;
      input  integer addr;
      output integer data;
   begin
      //                __    __    __    __    __    __    __    __
      //  aclk       __|  |__|  |__|  |__|  |__|  |__|  |__|  |__|  |
      //                ________   |     |
      //  araddr[]   XXX________   |     |
      //                ______     |     |
      //  arvalid    __/      \    |     |
      //             ____________  |     |
      //  arready    __/      \___ |     |
      //                           |     |
      //                            ________   |     |
      //   rdata[]               XXX________   |     |
      //                            ________   |     |
      //   rresp[]               XXX________   |     |
      //                            ______     |     |
      //   rvalid                __/      \    |     |
      //             ________________________  |     |
      //   rready    __/                  \___ |     |
      //                                  

      @(posedge aclk);
      m_axi_lite_araddr  <= #1 addr;
      m_axi_lite_arvalid <= #1 1'b1;
      m_axi_lite_rready  <= #1 1'b1;

      repeat(2) @(posedge aclk);
      data <= #1 m_axi_lite_rdata;

      @(posedge aclk);
      m_axi_lite_araddr  <= #1 0;
      m_axi_lite_arvalid <= #1 1'b0;
      m_axi_lite_rready  <= #1 1'b0;
   end
endtask

