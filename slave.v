//Описание функциональной модели slave
module slave(
input clk,
input arst,
input cmd,
input req,
input  [31:0] addr,
input  [31:0] wdata,
output  ack,
output [31:0] rdata);

reg [31:0] data_regs [0:100];
reg        cmd_reg;
reg [31:0] addr_reg;
reg        ack_reg;
reg [31:0] rdata_reg;

always @(posedge clk,posedge arst) 
begin
 if (arst) begin 
  rdata_reg = 0; end
   else begin
    if (req == 1'b1) begin
	//Операция записи
	 if (cmd == 1'b1) begin 
	  data_regs[addr] <= wdata;
	  addr_reg <= addr;
	  cmd_reg <= cmd;
	   end
	   //Операция чтения
	  else begin 
	   rdata_reg <= data_regs[addr]; end
	   ack_reg <= 1'b1;
	 end
	 //Когда сигнал запроса в неактивном состоянии
	 else begin
	 ack_reg <= 1'b0;
      end
	end
end

assign ack = ack_reg;
assign rdata = rdata_reg;

endmodule