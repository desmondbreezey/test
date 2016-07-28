/*
Описание модуля коммутатора
Префиксы портов:
master_N - сигнал идет от мастера с номером N к слэйву (выбор слэйва производится коммутатором)
slave_N  - сигнал идет от слэйва с номером N к соответствующему мастеру
*/
module crossbar(
input  master_1_req, 
input  master_2_req, 
input  master_1_cmd, 
input  master_2_cmd, 
input  slave_1_ack, 
input  slave_2_ack, 
input [31:0] master_1_addr, 
input [31:0] master_2_addr, 
input [31:0] master_1_wdata, 
input [31:0] master_2_wdata, 
input [31:0] slave_1_rdata, 
input [31:0] slave_2_rdata,
output slave_1_req, 
output slave_2_req, 
output slave_1_cmd, 
output slave_2_cmd, 
output master_1_ack, 
output master_2_ack,
output [31:0] slave_1_addr, 
output [31:0] slave_2_addr, 
output [31:0] master_1_rdata, 
output [31:0] master_2_rdata,
output [31:0] slave_1_wdata,
output [31:0] slave_2_wdata
);

reg [31:0] slave_addr_regs [0:1];
reg slave_req_regs [0:1];
reg slave_cmd_regs [0:1];
reg master_ack_regs [0:1];
reg [31:0] slave_wdata_regs [0:1];
reg [31:0] master_rdata_regs [0:1];

always @*
begin
   //при совпадении выбора "slave" для коммутации используется дисциплина round-robin
    if (master_1_addr[31] == master_2_addr[31]) begin 
	  slave_addr_regs[0] = master_1_addr;
	  slave_cmd_regs[0]  = master_1_cmd;
	  slave_req_regs[0]  = master_1_req;
	  slave_wdata_regs[0] = master_1_wdata;
	  master_ack_regs[0] = slave_1_ack;
	  master_rdata_regs[0] = slave_1_rdata;
	  slave_addr_regs[1] = master_2_addr; 
	  slave_cmd_regs[1]  = master_2_cmd;
	  slave_req_regs[1]  = master_2_req;
	  slave_wdata_regs[1] = master_2_wdata;
	  master_ack_regs[1] = slave_2_ack;
	  master_rdata_regs[1] = slave_2_rdata; 
	  end            //конец round-robin 	  
	   else begin
	  slave_addr_regs[master_1_addr[31]] = master_1_addr;
	  slave_cmd_regs[master_1_addr[31]]  = master_1_cmd;
	  slave_req_regs[master_1_addr[31]]  = master_1_req;
	  slave_wdata_regs[master_1_addr[31]] = master_1_wdata;
	  master_ack_regs[master_1_addr[31]] = slave_1_ack;
	  master_rdata_regs[master_1_addr[31]] = slave_1_rdata;
	  slave_addr_regs[master_2_addr[31]] = master_2_addr; 
	  slave_cmd_regs[master_2_addr[31]]  = master_2_cmd;
	  slave_req_regs[master_2_addr[31]]  = master_2_req;
	  slave_wdata_regs[master_2_addr[31]] = master_2_wdata;
	  master_ack_regs[master_2_addr[31]] = slave_2_ack;
	  master_rdata_regs[master_2_addr[31]] = slave_2_rdata;
	end
end

//Назначение выходов
assign slave_1_req = slave_req_regs[0];
assign slave_2_req = slave_req_regs[1];
assign slave_1_cmd = slave_cmd_regs[0];
assign slave_2_cmd = slave_cmd_regs[1];
assign master_1_ack = master_ack_regs[0];
assign master_2_ack = master_ack_regs[1];
assign slave_1_addr = slave_addr_regs[0];
assign slave_2_addr = slave_addr_regs[1];
assign slave_1_wdata = slave_wdata_regs[0];
assign slave_2_wdata = slave_wdata_regs[1];
assign master_1_rdata = master_rdata_regs[0];
assign master_2_rdata = master_rdata_regs[1];



endmodule
   