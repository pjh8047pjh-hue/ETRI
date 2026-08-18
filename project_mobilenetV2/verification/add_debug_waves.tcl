# MobileNetV2 end-to-end debug waves for Vivado 2020.2.
# Source this file after opening tb_mobilenet or tb_mobilenet_verify.

set D ""
foreach candidate {/tb_mobilenet/dut /tb_mobilenet_verify/dut} {
    if {[llength [get_objects -quiet "$candidate/clk"]] != 0} {
        set D $candidate
        break
    }
}

if {$D eq ""} {
    error "mobilenetV2 DUT not found. Open tb_mobilenet simulation first."
}

# Add a signal only when it survived elaboration. Vivado 2020.2 uses
# 'dec' for signed decimal and 'unsigned' for unsigned decimal.
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

add_wave_divider "00 TOP SEQUENCE"
jh_aw $D/clk
jh_aw $D/rst
jh_aw $D/start
jh_aw $D/pointwise_before_depth_valid
jh_aw $D/pointwise_buffer_write_done
jh_aw $D/pointwise_padded_valid
jh_aw $D/start_depth
jh_aw $D/depthwise_output_valid
jh_aw $D/write_done
jh_aw $D/pointwise_after_depth_valid
jh_aw $D/done
jh_aw $D/result dec

# Compact trace for output channel 0 / pixel 0. The two 1024-bit buses are
# reduced to lane 0 so one numerical sample can be followed end to end.
add_wave_divider "00A SAMPLE CH0 PIX0 TRACE"
jh_aw $D/u_pointwise_before_depth/u_core/input_valid
jh_aw [format {%s/u_pointwise_before_depth/input_rd_data[15:0]} $D] dec
jh_aw [format {%s/u_pointwise_before_depth/weight_data[15:0]} $D] dec
jh_aw $D/u_pointwise_before_depth/bias_data dec
jh_aw $D/u_pointwise_before_depth/u_core/dot_sum_q24 dec
jh_aw $D/u_pointwise_before_depth/u_core/shifted_q312 dec
jh_aw $D/u_pointwise_before_depth/u_core/output_valid
jh_aw $D/u_pointwise_before_depth/u_core/pointwise_before_depth_out dec
jh_aw $D/u_pointwise_output/data_valid
jh_aw $D/u_pointwise_output/data_out dec
jh_aw $D/depthwise/depth_mac/window_valid
jh_aw $D/depthwise/depth_mac/top_out dec
jh_aw $D/depthwise/depth_mac/mid_out dec
jh_aw $D/depthwise/depth_mac/bot_out dec
jh_aw $D/depthwise/depth_mac/relu_input dec
jh_aw $D/depthwise/depth_mac/depth_output_valid
jh_aw $D/depthwise/depth_mac/data_out dec
jh_aw $D/bram_d2p/wr_valid
jh_aw $D/bram_d2p/wr_data dec
jh_aw $D/bram_d2p/wr_addr unsigned
jh_aw $D/bram_d2p/wr_lane unsigned
jh_aw $D/pad/pad1/first
jh_aw [format {%s/pad/input_rd_data[15:0]} $D] dec
jh_aw [format {%s/pad/weight_data[15:0]} $D] dec
jh_aw $D/pad/pad1/sum dec
jh_aw $D/pad/pad1/bias_data dec
jh_aw $D/pad/pad1/output_valid
jh_aw $D/pad/pad1/pointwise_after_depth_out dec
jh_aw $D/done

add_wave_divider "01 POINTWISE BEFORE DEPTH CONTROL"
jh_aw $D/u_pointwise_before_depth/accept_start
jh_aw $D/u_pointwise_before_depth/busy
jh_aw $D/u_pointwise_before_depth/run
jh_aw $D/u_pointwise_before_depth/run_d1
jh_aw $D/u_pointwise_before_depth/mem_en
jh_aw $D/u_pointwise_before_depth/pixel_cnt unsigned
jh_aw $D/u_pointwise_before_depth/channel_cnt unsigned
jh_aw $D/u_pointwise_before_depth/last_request
jh_aw $D/u_pointwise_before_depth/input_rd_en
jh_aw $D/u_pointwise_before_depth/input_rd_addr unsigned
jh_aw $D/u_pointwise_before_depth/weight_addr unsigned
jh_aw $D/u_pointwise_before_depth/bias_addr unsigned
jh_aw $D/u_pointwise_before_depth/request_valid_d bin
jh_aw $D/u_pointwise_before_depth/last_request_d bin

add_wave_divider "02 POINTWISE BEFORE DEPTH DATA"
jh_aw $D/u_pointwise_before_depth/input_rd_data hex
jh_aw $D/u_pointwise_before_depth/weight_data hex
jh_aw $D/u_pointwise_before_depth/bias_data dec
jh_aw $D/u_pointwise_before_depth/u_core/input_valid
jh_aw $D/u_pointwise_before_depth/u_core/last_all
jh_aw $D/u_pointwise_before_depth/u_core/valid_delay bin
jh_aw $D/u_pointwise_before_depth/u_core/done_delay bin
jh_aw $D/u_pointwise_before_depth/u_core/adder_third_tree dec
jh_aw $D/u_pointwise_before_depth/u_core/dot_sum_q24 dec
jh_aw $D/u_pointwise_before_depth/u_core/bias_extended dec
jh_aw $D/u_pointwise_before_depth/u_core/biased_acc_q24 dec
jh_aw $D/u_pointwise_before_depth/u_core/shifted_q312 dec
jh_aw $D/u_pointwise_before_depth/u_core/output_valid
jh_aw $D/u_pointwise_before_depth/u_core/pointwise_before_depth_out dec
jh_aw $D/u_pointwise_before_depth/u_core/done

add_wave_divider "03 POINTWISE OUTPUT BUFFER WRITE"
jh_aw $D/u_pointwise_output/start_w
jh_aw $D/u_pointwise_output/dina dec
jh_aw $D/u_pointwise_output/bram_wr_en
jh_aw $D/u_pointwise_output/wr_addr unsigned
jh_aw $D/u_pointwise_output/bram_wr_addr unsigned
jh_aw $D/u_pointwise_output/bram_wr_data dec
jh_aw $D/u_pointwise_output/done_w

add_wave_divider "04 POINTWISE ZERO PADDING READ"
jh_aw $D/u_pointwise_output/reading
jh_aw $D/u_pointwise_output/rd_addr unsigned
jh_aw $D/u_pointwise_output/rd_channel_cnt unsigned
jh_aw $D/u_pointwise_output/rd_row_cnt unsigned
jh_aw $D/u_pointwise_output/rd_col_cnt unsigned
jh_aw $D/u_pointwise_output/real_slot
jh_aw $D/u_pointwise_output/real_slot_d1
jh_aw $D/u_pointwise_output/real_slot_d2
jh_aw $D/u_pointwise_output/bram_data_out dec
jh_aw $D/u_pointwise_output/data_out dec
jh_aw $D/u_pointwise_output/data_valid
jh_aw $D/u_pointwise_output/done_r
jh_aw $D/pointwise_padded_valid_d
jh_aw $D/start_depth

add_wave_divider "05 DEPTHWISE INPUT AND WINDOW"
jh_aw $D/depthwise/depth_mac/start
jh_aw $D/depthwise/depth_mac/run
jh_aw $D/depthwise/u1/run
jh_aw $D/depthwise/u1/channel unsigned
jh_aw $D/depthwise/u1/in_cnt unsigned
jh_aw $D/depthwise/depth_mac/input_channel_cnt unsigned
jh_aw $D/depthwise/depth_mac/row_cnt unsigned
jh_aw $D/depthwise/depth_mac/col_cnt unsigned
jh_aw $D/depthwise/depth_mac/channel_end
jh_aw $D/depthwise/depth_mac/input_data dec
jh_aw $D/depthwise/weight hex
jh_aw $D/depthwise/depth_mac/top dec
jh_aw $D/depthwise/depth_mac/mid dec
jh_aw $D/depthwise/depth_mac/bot dec
jh_aw $D/depthwise/depth_mac/window_valid

add_wave_divider "06 DEPTHWISE MAC BIAS RELU6"
jh_aw $D/depthwise/depth_mac/top_out dec
jh_aw $D/depthwise/depth_mac/mid_out dec
jh_aw $D/depthwise/depth_mac/bot_out dec
jh_aw $D/depthwise/depth_mac/output_valid_d bin
jh_aw $D/depthwise/depth_mac/channel_end_d bin
jh_aw $D/depthwise/depth_mac/bias_addr unsigned
jh_aw $D/depthwise/depth_mac/bias_data dec
jh_aw $D/depthwise/depth_mac/bias_extended dec
jh_aw $D/depthwise/depth_mac/relu_input dec
jh_aw $D/depthwise/depth_mac/depth_output_valid
jh_aw $D/depthwise/depth_mac/data_out dec

add_wave_divider "07 DEPTH TO POINTWISE BRAM WRITE"
jh_aw $D/bram_d2p/wr_valid
jh_aw $D/bram_d2p/wr_data dec
jh_aw $D/bram_d2p/wr_pixel_cnt unsigned
jh_aw $D/bram_d2p/wr_channel_cnt unsigned
jh_aw $D/bram_d2p/wr_addr unsigned
jh_aw $D/bram_d2p/wr_lane unsigned
jh_aw $D/bram_d2p/wr_wea hex
jh_aw $D/bram_d2p/wr_dina hex
jh_aw $D/bram_d2p/write_done

add_wave_divider "08 DEPTH TO POINTWISE BRAM READ"
jh_aw $D/bram_d2p/input_rd_en
jh_aw $D/bram_d2p/input_rd_addr unsigned
jh_aw $D/bram_d2p/input_rd_data hex

add_wave_divider "09 POINTWISE AFTER DEPTH CONTROL"
jh_aw $D/pad/start
jh_aw $D/pad/run
jh_aw $D/pad/run_d1
jh_aw $D/pad/mem_en
jh_aw $D/pad/pixel_cnt unsigned
jh_aw $D/pad/chunk_cnt unsigned
jh_aw $D/pad/channel_cnt unsigned
jh_aw $D/pad/last_input
jh_aw $D/pad/input_rd_en
jh_aw $D/pad/input_rd_addr unsigned
jh_aw $D/pad/weight_addr unsigned
jh_aw $D/pad/bias_addr unsigned
jh_aw $D/pad/first_d bin
jh_aw $D/pad/last_d bin
jh_aw $D/pad/done_d bin

add_wave_divider "10 POINTWISE AFTER DEPTH DATA"
jh_aw $D/pad/input_rd_data hex
jh_aw $D/pad/weight_data hex
jh_aw $D/pad/bias_data dec
jh_aw $D/pad/pad1/first
jh_aw $D/pad/pad1/last
jh_aw $D/pad/pad1/last_all
jh_aw $D/pad/pad1/first_output bin
jh_aw $D/pad/pad1/last_output bin
jh_aw $D/pad/pad1/done_delay bin
jh_aw $D/pad/pad1/adder_third_tree dec
jh_aw $D/pad/pad1/sum dec
jh_aw $D/pad/pad1/bias_extended dec
jh_aw $D/pad/pad1/output_valid
jh_aw $D/pad/pad1/pointwise_after_depth_out dec
jh_aw $D/pad/pad1/done

add_wave_divider "10A SKIP CONNECTION"
jh_aw $D/pad/pw_valid
jh_aw $D/pad/pw_raw dec
jh_aw $D/pad/skip_pixel_cnt unsigned
jh_aw $D/pad/skip_channel_cnt unsigned
jh_aw $D/pad/skip_channel_hold unsigned
jh_aw $D/pad/pw_hold dec
jh_aw $D/pad/skip_bram_data hex
jh_aw $D/pad/skip_lane dec
jh_aw $D/pad/skip_valid_d bin
jh_aw $D/pad/skip_done_d bin
jh_aw $D/pad/output_valid
jh_aw $D/pad/pointwise_after_depth_out dec

add_wave_divider "11 FINAL OUTPUT"
jh_aw $D/pointwise_after_depth_valid
jh_aw $D/pointwise_after_depth_out_full dec
jh_aw $D/result dec
jh_aw $D/done

wave zoom full
puts "MobileNetV2 wave setup complete: $D"
