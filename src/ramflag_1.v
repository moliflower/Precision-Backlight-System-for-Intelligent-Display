  module ramflag_1(
    input clk,   // 25Mclk
    input rst_n,
    input pclk,
    input vs,
    input hs,
    input de,
    input [7:0]R,
    input [7:0]G,
    input [7:0]B,
    input key,
    output  sdbpflag_wire,
    output  [15:0] wtdina_wire,
    output  [9:0] wtaddr_wire
);
reg [11:0] cnt;  //用于延迟1250个dclk 等待配置寄存器时间。
reg [30:0] cnt1; //用于周期性发送sdbpflag信号，可以设置cnt1长度修改发送sdbpflag信号时间间隔
reg [9:0] cnt2;  // 用于每帧暂存时间
reg [13:0]  cnt3;  // 每一轮addr自加+1 当addr=cnt3时点亮对应位置的灯珠
reg flag= 'd0; //标志配置寄存器结束，可以发送sdbp数据了;
reg sdbpflag;
reg [15:0]wtdina;
reg [9:0]wtaddr;
assign sdbpflag_wire = sdbpflag;
assign wtdina_wire = wtdina;
assign wtaddr_wire = wtaddr;
reg [10:0] x;
reg [9:0] y;

//cnt记满后视为配置寄存器完毕
always @(posedge clk or negedge rst_n)   
 begin
    if(!rst_n)
        begin
            flag <= 0;
            cnt <= 0;
        end
    else if(cnt < 2500)
    begin
        flag <= 0;
        cnt <= cnt + 1;
    end
    else if(cnt == 2500)
    begin
        flag <= 1;
    end
end
//cnt1用来计数sdbpflag的周期
always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        cnt1 <= 0;
    else if(cnt1 >= 420_000)begin
        cnt1 <= 0;
    end
    else
        cnt1 <= cnt1 + 1;
end
//cnt2用来计数流水灯状态下每颗灯点亮的持续时间
always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        begin
            cnt2 <= 0;
        end
    else if(cnt1 == 0 && flag)
            begin 
//  cnt2是一颗灯保持亮的速率
                if(cnt2 == 19)
                    begin
                        cnt2 <= 0;
                    end
                else 
                    begin
                        cnt2 <= cnt2 + 1;
                    end
            end
end
//cnt3用来计数点亮灯珠的位置
always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)begin
        cnt3 <= 0;
    end
    else if(cnt1 == 1 && cnt2 == 0 && flag)begin
        if(cnt3 >= 359)begin
            cnt3 <= 0;
        end
        else begin
            cnt3 <= cnt3 + 1;
        end
    end
end
//以下always块作用为控制输出信号
always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        sdbpflag <= 0;
    else if(cnt1 == 1 && flag)begin
        sdbpflag <= 1;
    end
    else if(cnt1 == 30 && flag)begin
        sdbpflag <= 0;  
    end
end
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)begin
        wtaddr <= 0;
    end
    else if(cnt1 == 3) begin
        wtaddr <= 0;
    end 
    else if (cnt1 > 4 && cnt1 <=4+360 && flag)begin//cnt1:5-364 wtaddr:1-360
        wtaddr <= wtaddr + 1;
    end
    else if(cnt1 > 4+360) begin
        wtaddr <= 0; 
    end
end
//流水灯 换显示形式时把此always块注释掉
//always@(posedge clk or negedge rst_n)
//  begin
//      if(!rst_n)
//          wtdina <= 0;
//      else if(wtaddr==cnt3&&flag)
//              wtdina <= 16'hffff;
//      else
//          wtdina <= 0;
//  end
//全亮 
wire [15:0] wtdout;
 always@(posedge clk or negedge rst_n)
 begin
     if(!rst_n)begin
         wtdina <= 0;
     end
     else if(cnt1>3&&cnt1<=364&&flag)begin
         wtdina <= wtdout; 
     end
     else
         wtdina <= 0;
 end
// 1/3全亮度 1/3一半亮度 1/3暗 换显示形式时把此always块注释掉
// always@(posedge clk or negedge rst_n)begin 
//     if(!rst_n)begin
//         wtdina <= 0;    
//     end 
//     else if(wtaddr%24==0 || (wtaddr-1)%24==0 || (wtaddr-2)%24==0 || (wtaddr-3)%24==0 || (wtaddr-4)%24==0 || (wtaddr-5)%24==0 ||(wtaddr-6)%24==0 || (wtaddr-7)%24==0)
//         wtdina <= 16'hffff;
//         else if((wtaddr-8)%24==0 || (wtaddr-9)%24==0 || (wtaddr-10)%24==0 || (wtaddr-11)%24==0||(wtaddr-12)%24==0 || (wtaddr-13)%24==0 || (wtaddr-14)%24==0 || (wtaddr-15)%24==0)
//             wtdina <= 16'h0100;
//     else
//     wtdina <= 0;
// end 
//亮固定某一个灯珠 换显示形式时把此always块注释掉
// always@(posedge clk or negedge rst_n)begin 
// if(!rst_n)begin
//         wtdina <= 0;
//     end 
// else if(wtaddr == 23)begin//wtaddr == x代表第x+1颗灯
//         wtdina <= 16'hffff;
//     end 
// else begin
//         wtdina <= 0;
//     end
// end
reg de1;
reg [15:0] light;
reg [15:0] maxlight[0:359];
reg [5:0] x1;
reg [5:0] y1;
reg [4:0] xn;
reg [3:0] yn;
reg [8:0]index;
always @(posedge pclk)
begin
    de1 <= de;
    if(vs) begin
        x <= 0;
        y <= 0;
    end else if (hs) begin
        x <= 0;
    end else if (de) begin
        x <= x + 1;
    end else if (de1==1&&de==0) begin
        y <= y + 1;
    end
    light <= 77*R + 150*G + 29*B;

    if(hs) begin
        x1 <= 0;
        xn <= 0;
    end else begin
        if(de) begin 
            if(x1 >= 52)begin
                x1 <= 0;
                if(xn<23) begin
                    xn <= xn + 1;
                end
            end else begin
                x1 <= x1 + 1;
            end
        end
    end
    if(vs) begin
        y1 <= 0;
        yn <= 0;
    end else begin
        if(de1==1&&de==0) begin 
            if(y1 >= 52)begin
                y1 <= 0;
                if(yn<14) begin
                    yn <= yn + 1;
                end
            end else begin
                y1 <= y1 + 1;
            end
        end
    end
    index <= yn*24 + xn;
    if(x1 == 0&& y1 == 0) begin
        maxlight[index] <= 0;
    end else if(maxlight[index] < light) begin
        maxlight[index] <= light;
    end
end

reg cea,cea1,cea2;
wire [8:0]adb;
reg[15:0] din,din1,din2;
reg [8:0]index1,index2;
 
assign adb = cnt1-4;

always @(posedge pclk)
begin
    cea <= (x1==52&&y1==52);
    cea1 <= cea;
    cea2 <= cea1;
    din1 <= maxlight[index];
    din2 <= (xn < 11)? maxlight[index]:16'hffff;
    din <= (key) ?din1 :din2; 
    index1 <= index;
    index2 <= index1;
end
sdpb360 inst1(
        .clka(pclk), //input clka
        .cea(cea1), //input cea
        .reseta(~rst_n), //input reseta
        .ada(index2), //input [8:0] ada
        .din(din), //input [15:0] din

        .dout(wtdout), //output [15:0] dout
        .adb(adb), //input [8:0] adb
        .clkb(clk), //input clkb
        .ceb(1), //input ceb
        .resetb(~rst_n), //input resetb
        .oce(1) //input oce
    );

endmodule