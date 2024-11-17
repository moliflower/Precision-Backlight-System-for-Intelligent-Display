module gw_gao(
    \u1/R[7] ,
    \u1/R[6] ,
    \u1/R[5] ,
    \u1/R[4] ,
    \u1/R[3] ,
    \u1/R[2] ,
    \u1/R[1] ,
    \u1/R[0] ,
    \u1/G[7] ,
    \u1/G[6] ,
    \u1/G[5] ,
    \u1/G[4] ,
    \u1/G[3] ,
    \u1/G[2] ,
    \u1/G[1] ,
    \u1/G[0] ,
    \u1/B[7] ,
    \u1/B[6] ,
    \u1/B[5] ,
    \u1/B[4] ,
    \u1/B[3] ,
    \u1/B[2] ,
    \u1/B[1] ,
    \u1/B[0] ,
    \u1/light[15] ,
    \u1/light[14] ,
    \u1/light[13] ,
    \u1/light[12] ,
    \u1/light[11] ,
    \u1/light[10] ,
    \u1/light[9] ,
    \u1/light[8] ,
    \u1/light[7] ,
    \u1/light[6] ,
    \u1/light[5] ,
    \u1/light[4] ,
    \u1/light[3] ,
    \u1/light[2] ,
    \u1/light[1] ,
    \u1/light[0] ,
    \u1/index[8] ,
    \u1/index[7] ,
    \u1/index[6] ,
    \u1/index[5] ,
    \u1/index[4] ,
    \u1/index[3] ,
    \u1/index[2] ,
    \u1/index[1] ,
    \u1/index[0] ,
    \u1/pclk ,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input \u1/R[7] ;
input \u1/R[6] ;
input \u1/R[5] ;
input \u1/R[4] ;
input \u1/R[3] ;
input \u1/R[2] ;
input \u1/R[1] ;
input \u1/R[0] ;
input \u1/G[7] ;
input \u1/G[6] ;
input \u1/G[5] ;
input \u1/G[4] ;
input \u1/G[3] ;
input \u1/G[2] ;
input \u1/G[1] ;
input \u1/G[0] ;
input \u1/B[7] ;
input \u1/B[6] ;
input \u1/B[5] ;
input \u1/B[4] ;
input \u1/B[3] ;
input \u1/B[2] ;
input \u1/B[1] ;
input \u1/B[0] ;
input \u1/light[15] ;
input \u1/light[14] ;
input \u1/light[13] ;
input \u1/light[12] ;
input \u1/light[11] ;
input \u1/light[10] ;
input \u1/light[9] ;
input \u1/light[8] ;
input \u1/light[7] ;
input \u1/light[6] ;
input \u1/light[5] ;
input \u1/light[4] ;
input \u1/light[3] ;
input \u1/light[2] ;
input \u1/light[1] ;
input \u1/light[0] ;
input \u1/index[8] ;
input \u1/index[7] ;
input \u1/index[6] ;
input \u1/index[5] ;
input \u1/index[4] ;
input \u1/index[3] ;
input \u1/index[2] ;
input \u1/index[1] ;
input \u1/index[0] ;
input \u1/pclk ;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire \u1/R[7] ;
wire \u1/R[6] ;
wire \u1/R[5] ;
wire \u1/R[4] ;
wire \u1/R[3] ;
wire \u1/R[2] ;
wire \u1/R[1] ;
wire \u1/R[0] ;
wire \u1/G[7] ;
wire \u1/G[6] ;
wire \u1/G[5] ;
wire \u1/G[4] ;
wire \u1/G[3] ;
wire \u1/G[2] ;
wire \u1/G[1] ;
wire \u1/G[0] ;
wire \u1/B[7] ;
wire \u1/B[6] ;
wire \u1/B[5] ;
wire \u1/B[4] ;
wire \u1/B[3] ;
wire \u1/B[2] ;
wire \u1/B[1] ;
wire \u1/B[0] ;
wire \u1/light[15] ;
wire \u1/light[14] ;
wire \u1/light[13] ;
wire \u1/light[12] ;
wire \u1/light[11] ;
wire \u1/light[10] ;
wire \u1/light[9] ;
wire \u1/light[8] ;
wire \u1/light[7] ;
wire \u1/light[6] ;
wire \u1/light[5] ;
wire \u1/light[4] ;
wire \u1/light[3] ;
wire \u1/light[2] ;
wire \u1/light[1] ;
wire \u1/light[0] ;
wire \u1/index[8] ;
wire \u1/index[7] ;
wire \u1/index[6] ;
wire \u1/index[5] ;
wire \u1/index[4] ;
wire \u1/index[3] ;
wire \u1/index[2] ;
wire \u1/index[1] ;
wire \u1/index[0] ;
wire \u1/pclk ;
wire tms_pad_i;
wire tck_pad_i;
wire tdi_pad_i;
wire tdo_pad_o;
wire tms_i_c;
wire tck_i_c;
wire tdi_i_c;
wire tdo_o_c;
wire [9:0] control0;
wire gao_jtag_tck;
wire gao_jtag_reset;
wire run_test_idle_er1;
wire run_test_idle_er2;
wire shift_dr_capture_dr;
wire update_dr;
wire pause_dr;
wire enable_er1;
wire enable_er2;
wire gao_jtag_tdi;
wire tdo_er1;

IBUF tms_ibuf (
    .I(tms_pad_i),
    .O(tms_i_c)
);

IBUF tck_ibuf (
    .I(tck_pad_i),
    .O(tck_i_c)
);

IBUF tdi_ibuf (
    .I(tdi_pad_i),
    .O(tdi_i_c)
);

OBUF tdo_obuf (
    .I(tdo_o_c),
    .O(tdo_pad_o)
);

GW_JTAG  u_gw_jtag(
    .tms_pad_i(tms_i_c),
    .tck_pad_i(tck_i_c),
    .tdi_pad_i(tdi_i_c),
    .tdo_pad_o(tdo_o_c),
    .tck_o(gao_jtag_tck),
    .test_logic_reset_o(gao_jtag_reset),
    .run_test_idle_er1_o(run_test_idle_er1),
    .run_test_idle_er2_o(run_test_idle_er2),
    .shift_dr_capture_dr_o(shift_dr_capture_dr),
    .update_dr_o(update_dr),
    .pause_dr_o(pause_dr),
    .enable_er1_o(enable_er1),
    .enable_er2_o(enable_er2),
    .tdi_o(gao_jtag_tdi),
    .tdo_er1_i(tdo_er1),
    .tdo_er2_i(1'b0)
);

gw_con_top  u_icon_top(
    .tck_i(gao_jtag_tck),
    .tdi_i(gao_jtag_tdi),
    .tdo_o(tdo_er1),
    .rst_i(gao_jtag_reset),
    .control0(control0[9:0]),
    .enable_i(enable_er1),
    .shift_dr_capture_dr_i(shift_dr_capture_dr),
    .update_dr_i(update_dr)
);

ao_top_0  u_la0_top(
    .control(control0[9:0]),
    .trig0_i({\u1/R[7] ,\u1/R[6] ,\u1/R[5] ,\u1/R[4] ,\u1/R[3] ,\u1/R[2] ,\u1/R[1] ,\u1/R[0] ,\u1/G[7] ,\u1/G[6] ,\u1/G[5] ,\u1/G[4] ,\u1/G[3] ,\u1/G[2] ,\u1/G[1] ,\u1/G[0] ,\u1/B[7] ,\u1/B[6] ,\u1/B[5] ,\u1/B[4] ,\u1/B[3] ,\u1/B[2] ,\u1/B[1] ,\u1/B[0] ,\u1/light[15] ,\u1/light[14] ,\u1/light[13] ,\u1/light[12] ,\u1/light[11] ,\u1/light[10] ,\u1/light[9] ,\u1/light[8] ,\u1/light[7] ,\u1/light[6] ,\u1/light[5] ,\u1/light[4] ,\u1/light[3] ,\u1/light[2] ,\u1/light[1] ,\u1/light[0] ,\u1/index[8] ,\u1/index[7] ,\u1/index[6] ,\u1/index[5] ,\u1/index[4] ,\u1/index[3] ,\u1/index[2] ,\u1/index[1] ,\u1/index[0] }),
    .data_i({\u1/R[7] ,\u1/R[6] ,\u1/R[5] ,\u1/R[4] ,\u1/R[3] ,\u1/R[2] ,\u1/R[1] ,\u1/R[0] ,\u1/G[7] ,\u1/G[6] ,\u1/G[5] ,\u1/G[4] ,\u1/G[3] ,\u1/G[2] ,\u1/G[1] ,\u1/G[0] ,\u1/B[7] ,\u1/B[6] ,\u1/B[5] ,\u1/B[4] ,\u1/B[3] ,\u1/B[2] ,\u1/B[1] ,\u1/B[0] ,\u1/light[15] ,\u1/light[14] ,\u1/light[13] ,\u1/light[12] ,\u1/light[11] ,\u1/light[10] ,\u1/light[9] ,\u1/light[8] ,\u1/light[7] ,\u1/light[6] ,\u1/light[5] ,\u1/light[4] ,\u1/light[3] ,\u1/light[2] ,\u1/light[1] ,\u1/light[0] ,\u1/index[8] ,\u1/index[7] ,\u1/index[6] ,\u1/index[5] ,\u1/index[4] ,\u1/index[3] ,\u1/index[2] ,\u1/index[1] ,\u1/index[0] }),
    .clk_i(\u1/pclk )
);

endmodule
