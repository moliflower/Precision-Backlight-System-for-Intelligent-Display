//Copyright (C)2014-2024 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.10 (64-bit) 
//Created Time: 2024-08-02 11:58:45
create_clock -name I_clk -period 20 -waveform {0 10} [get_ports {I_clk}] -add

