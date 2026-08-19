# MobileNetV2 2-way parallel debug waves for Vivado 2020.2.
# Run Behavioral Simulation first, then source this file in the Tcl console:
#   source project_mobilenetV2/verification/add_debug_waves.tcl

set D ""
foreach candidate {/tb_mobilenet/dut /tb_mobilenet_verify/dut} {
    if {[llength [get_objects -quiet "$candidate/clk"]] != 0} {
        set D $candidate
        break
    }
}

if {$D eq ""} {
    error "mobilenetV2 DUT not found. Open tb_mobilenet Behavioral Simulation first."
}

# Missing or optimized-away objects are skipped so one stale signal does not
# stop the rest of the waveform setup. Use dec instead of unsupported signed.
proc jh_aw {path {radix ""}} {
    set obj [get_objects -quiet $path]
    if {[llength $obj] == 0} {
        puts "SKIP: $path"
        return
    }

    if {$radix eq ""} {
        add_wave -quiet $obj
    } else {
        add_wave -quiet -radix $radix $obj
    }
}

proc jh_div {name} {
    if {[llength [info commands add_wave_divider]] != 0} {
        add_wave_divider $name
    } else {
        puts "---- $name ----"
    }
}

jh_div "00 TOP SEQUENCE"
jh_aw $D/clk
jh_aw $D/rst
jh_aw $D/start
jh_aw $D/pointwise_before_depth_valid
jh_aw $D/pw_prefill_cnt unsigned
jh_aw $D/pw_depth_start
jh_aw $D/pointwise_buffer_write_done
jh_aw $D/pointwise_padded_valid
jh_aw $D/start_depth
jh_aw $D/depthwise_output_valid
jh_aw $D/write_done
jh_aw $D/pointwise_after_depth_valid
jh_aw $D/result dec
jh_aw $D/done

# Current debug COE expected values for pair 0:
# PW-before p0 = 0x0401_0000, Depth first = 0x2784_0780,
# final output channel 0 pixel 0/1 = 1984 then 3264.
jh_div "00A SAMPLE PAIR0 TRACE"
jh_aw $D/u_pointwise_before_depth/channel_pair_cnt unsigned
jh_aw $D/u_pointwise_before_depth/pixel_cnt unsigned
jh_aw $D/u_pointwise_before_depth/request_valid_d bin
jh_aw [format {%s/u_pointwise_before_depth/input_rd_data[15:0]} $D] dec
jh_aw [format {%s/u_pointwise_before_depth/input_rd_data[31:16]} $D] dec
jh_aw $D/u_pointwise_before_depth/bias_data_even dec
jh_aw $D/u_pointwise_before_depth/bias_data_odd dec
jh_aw $D/u_pointwise_before_depth/u_core_even/pointwise_before_depth_out dec
jh_aw $D/u_pointwise_before_depth/u_core_odd/pointwise_before_depth_out dec
jh_aw $D/pointwise_before_depth_out hex
jh_aw $D/u_pointwise_output/bram_wr_data hex
jh_aw $D/u_pointwise_output/data_out hex
jh_aw $D/depthwise/depth_mac_even/input_data dec
jh_aw $D/depthwise/depth_mac_odd/input_data dec
jh_aw $D/depthwise/depth_mac_even/relu_input dec
jh_aw $D/depthwise/depth_mac_odd/relu_input dec
jh_aw $D/depthwise/depth_mac_even/data_out dec
jh_aw $D/depthwise/depth_mac_odd/data_out dec
jh_aw $D/depthwise_data_out hex
jh_aw $D/bram_d2p/wr_valid
jh_aw $D/bram_d2p/wr_pair_cnt unsigned
jh_aw $D/bram_d2p/wr_pixel_cnt unsigned
jh_aw $D/bram_d2p/wr_addr unsigned
jh_aw $D/bram_d2p/wr_lane unsigned
jh_aw $D/bram_d2p/wr_data hex
jh_aw $D/pad/pw_raw_even dec
jh_aw $D/pad/pw_raw_odd dec
jh_aw $D/pad/skip_lane_even dec
jh_aw $D/pad/skip_lane_odd dec
jh_aw $D/pad/odd_pending
jh_aw $D/pad/pointwise_after_depth_out dec
jh_aw $D/pad/output_valid
jh_aw $D/result dec

jh_div "01 PW BEFORE CONTROL"
jh_aw $D/u_pointwise_before_depth/accept_start
jh_aw $D/u_pointwise_before_depth/busy
jh_aw $D/u_pointwise_before_depth/run
jh_aw $D/u_pointwise_before_depth/run_d1
jh_aw $D/u_pointwise_before_depth/mem_en
jh_aw $D/u_pointwise_before_depth/channel_pair_cnt unsigned
jh_aw $D/u_pointwise_before_depth/pixel_cnt unsigned
jh_aw $D/u_pointwise_before_depth/last_request
jh_aw $D/u_pointwise_before_depth/input_rd_en
jh_aw $D/u_pointwise_before_depth/input_rd_addr unsigned
jh_aw $D/u_pointwise_before_depth/weight_addr_even unsigned
jh_aw $D/u_pointwise_before_depth/weight_addr_odd unsigned
jh_aw $D/u_pointwise_before_depth/bias_addr_even unsigned
jh_aw $D/u_pointwise_before_depth/bias_addr_odd unsigned
jh_aw $D/u_pointwise_before_depth/request_valid_d bin
jh_aw $D/u_pointwise_before_depth/last_request_d bin

jh_div "02 PW BEFORE EVEN ODD DATA"
jh_aw $D/u_pointwise_before_depth/input_rd_data hex
jh_aw $D/u_pointwise_before_depth/weight_data_even hex
jh_aw $D/u_pointwise_before_depth/weight_data_odd hex
jh_aw $D/u_pointwise_before_depth/bias_data_even dec
jh_aw $D/u_pointwise_before_depth/bias_data_odd dec
jh_aw $D/u_pointwise_before_depth/u_core_even/input_valid
jh_aw $D/u_pointwise_before_depth/u_core_even/dot_sum_q24 dec
jh_aw $D/u_pointwise_before_depth/u_core_even/shifted_q312 dec
jh_aw $D/u_pointwise_before_depth/u_core_even/pointwise_before_depth_out dec
jh_aw $D/u_pointwise_before_depth/u_core_odd/dot_sum_q24 dec
jh_aw $D/u_pointwise_before_depth/u_core_odd/shifted_q312 dec
jh_aw $D/u_pointwise_before_depth/u_core_odd/pointwise_before_depth_out dec
jh_aw $D/u_pointwise_before_depth/output_valid
jh_aw $D/u_pointwise_before_depth/pointwise_before_depth_out hex
jh_aw $D/u_pointwise_before_depth/done

jh_div "03 PW PAIR BUFFER WRITE"
jh_aw $D/u_pointwise_output/start_w
jh_aw $D/u_pointwise_output/dina_even dec
jh_aw $D/u_pointwise_output/dina_odd dec
jh_aw $D/u_pointwise_output/quantized_even dec
jh_aw $D/u_pointwise_output/quantized_odd dec
jh_aw $D/u_pointwise_output/wr_addr unsigned
jh_aw $D/u_pointwise_output/bram_wr_en
jh_aw $D/u_pointwise_output/bram_wr_addr unsigned
jh_aw $D/u_pointwise_output/bram_wr_data hex
jh_aw $D/u_pointwise_output/done_w

jh_div "04 PW PAIR ZERO PADDING READ"
jh_aw $D/u_pointwise_output/reading
jh_aw $D/u_pointwise_output/rd_addr unsigned
jh_aw $D/u_pointwise_output/rd_channel_pair_cnt unsigned
jh_aw $D/u_pointwise_output/rd_row_cnt unsigned
jh_aw $D/u_pointwise_output/rd_col_cnt unsigned
jh_aw $D/u_pointwise_output/real_slot
jh_aw $D/u_pointwise_output/real_slot_d1
jh_aw $D/u_pointwise_output/real_slot_d2
jh_aw $D/u_pointwise_output/bram_data_out hex
jh_aw $D/u_pointwise_output/data_out hex
jh_aw $D/u_pointwise_output/data_valid
jh_aw $D/u_pointwise_output/done_r
jh_aw $D/start_depth

jh_div "05 DEPTH PAIR INPUT WEIGHT BIAS"
jh_aw $D/depthwise/u1/run
jh_aw $D/depthwise/u1/in_cnt unsigned
jh_aw $D/depthwise/u1/channel_pair unsigned
jh_aw $D/depthwise/u1/channel_even_addr unsigned
jh_aw $D/depthwise/u1/channel_odd_addr unsigned
jh_aw $D/depthwise/weight_even hex
jh_aw $D/depthwise/weight_odd hex
jh_aw $D/depthwise/bias_pair_addr unsigned
jh_aw $D/depthwise/bias_even dec
jh_aw $D/depthwise/bias_odd dec
jh_aw $D/depthwise/input_data hex

jh_div "06 DEPTH EVEN MAC"
jh_aw $D/depthwise/depth_mac_even/run
jh_aw $D/depthwise/depth_mac_even/input_channel_cnt unsigned
jh_aw $D/depthwise/depth_mac_even/row_cnt unsigned
jh_aw $D/depthwise/depth_mac_even/col_cnt unsigned
jh_aw $D/depthwise/depth_mac_even/window_valid
jh_aw $D/depthwise/depth_mac_even/top dec
jh_aw $D/depthwise/depth_mac_even/mid dec
jh_aw $D/depthwise/depth_mac_even/bot dec
jh_aw $D/depthwise/depth_mac_even/top_out dec
jh_aw $D/depthwise/depth_mac_even/mid_out dec
jh_aw $D/depthwise/depth_mac_even/bot_out dec
jh_aw $D/depthwise/depth_mac_even/bias_data dec
jh_aw $D/depthwise/depth_mac_even/relu_input dec
jh_aw $D/depthwise/depth_mac_even/relu_input_reg dec
jh_aw $D/depthwise/depth_mac_even/output_valid_d bin
jh_aw $D/depthwise/depth_mac_even/channel_step
jh_aw $D/depthwise/depth_mac_even/depth_output_valid
jh_aw $D/depthwise/depth_mac_even/data_out dec

jh_div "06A DEPTH ODD MAC"
jh_aw $D/depthwise/depth_mac_odd/run
jh_aw $D/depthwise/depth_mac_odd/input_channel_cnt unsigned
jh_aw $D/depthwise/depth_mac_odd/row_cnt unsigned
jh_aw $D/depthwise/depth_mac_odd/col_cnt unsigned
jh_aw $D/depthwise/depth_mac_odd/window_valid
jh_aw $D/depthwise/depth_mac_odd/top_out dec
jh_aw $D/depthwise/depth_mac_odd/mid_out dec
jh_aw $D/depthwise/depth_mac_odd/bot_out dec
jh_aw $D/depthwise/depth_mac_odd/bias_data dec
jh_aw $D/depthwise/depth_mac_odd/relu_input dec
jh_aw $D/depthwise/depth_mac_odd/relu_input_reg dec
jh_aw $D/depthwise/depth_mac_odd/depth_output_valid
jh_aw $D/depthwise/depth_mac_odd/data_out dec

jh_div "07 DEPTH PAIR TO PW BRAM WRITE"
jh_aw $D/bram_d2p/wr_valid
jh_aw $D/bram_d2p/wr_data hex
jh_aw $D/bram_d2p/wr_pixel_cnt unsigned
jh_aw $D/bram_d2p/wr_pair_cnt unsigned
jh_aw $D/bram_d2p/wr_addr unsigned
jh_aw $D/bram_d2p/wr_lane unsigned
jh_aw $D/bram_d2p/wr_wea hex
jh_aw $D/bram_d2p/port_a_wea hex
jh_aw $D/bram_d2p/wr_dina hex
jh_aw $D/bram_d2p/write_done

jh_div "08 D2P TRUE DUAL PORT READ"
jh_aw $D/bram_d2p/input_rd_en
jh_aw $D/bram_d2p/input_rd_addr_a unsigned
jh_aw $D/bram_d2p/input_rd_addr_b unsigned
jh_aw $D/bram_d2p/input_rd_data_a hex
jh_aw $D/bram_d2p/input_rd_data_b hex

jh_div "09 PW AFTER PIXEL PAIR CONTROL"
jh_aw $D/pad/start
jh_aw $D/pad/run
jh_aw $D/pad/run_d1
jh_aw $D/pad/mem_en
jh_aw $D/pad/channel_cnt unsigned
jh_aw $D/pad/pixel_pair_cnt unsigned
jh_aw $D/pad/pixel_even unsigned
jh_aw $D/pad/chunk_cnt unsigned
jh_aw $D/pad/last_input
jh_aw $D/pad/input_rd_en
jh_aw $D/pad/input_rd_addr_a unsigned
jh_aw $D/pad/input_rd_addr_b unsigned
jh_aw $D/pad/weight_addr unsigned
jh_aw $D/pad/bias_addr unsigned
jh_aw $D/pad/first_d bin
jh_aw $D/pad/last_d bin
jh_aw $D/pad/done_d bin

jh_div "10 PW AFTER EVEN ODD MAC"
jh_aw $D/pad/input_rd_data_a hex
jh_aw $D/pad/input_rd_data_b hex
jh_aw $D/pad/weight_data hex
jh_aw $D/pad/bias_data dec
jh_aw $D/pad/pad_even/first
jh_aw $D/pad/pad_even/last
jh_aw $D/pad/pad_even/adder_third_tree dec
jh_aw $D/pad/pad_even/sum dec
jh_aw $D/pad/pad_even/pointwise_after_depth_out dec
jh_aw $D/pad/pad_odd/adder_third_tree dec
jh_aw $D/pad/pad_odd/sum dec
jh_aw $D/pad/pad_odd/pointwise_after_depth_out dec
jh_aw $D/pad/pw_valid
jh_aw $D/pad/pw_done
jh_aw $D/pad/pw_raw_even dec
jh_aw $D/pad/pw_raw_odd dec

jh_div "10A SKIP AND SERIAL OUTPUT"
jh_aw $D/pad/skip_pixel_pair_cnt unsigned
jh_aw $D/pad/skip_pixel_even unsigned
jh_aw $D/pad/skip_channel_cnt unsigned
jh_aw $D/pad/skip_channel_hold unsigned
jh_aw $D/pad/pw_hold_even dec
jh_aw $D/pad/pw_hold_odd dec
jh_aw $D/pad/skip_lane_even dec
jh_aw $D/pad/skip_lane_odd dec
jh_aw $D/pad/skip_valid_d bin
jh_aw $D/pad/skip_done_d bin
jh_aw $D/pad/odd_result_hold dec
jh_aw $D/pad/odd_pending
jh_aw $D/pad/final_pair_hold
jh_aw $D/pad/output_valid
jh_aw $D/pad/pointwise_after_depth_out dec
jh_aw $D/pad/done

jh_div "11 FINAL OUTPUT"
jh_aw $D/pointwise_after_depth_valid
jh_aw $D/pointwise_after_depth_out_full dec
jh_aw $D/result dec
jh_aw $D/done

wave zoom full
puts "MobileNetV2 pair wave setup complete: $D"
puts "Expected first final samples with current debug COEs: 1984, 3264"
