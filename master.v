//Описание функциональной модели мастера
module master
(
     //Набор интерфейсов для загрузки тестовых векторов
     input  [31:0]         i_test_addr,
	 input  [31:0]         i_test_wdata,
	 input                 i_test_cmd,
	 input                 i_test_req,
	 input                 i_test_enable,
	 input                 i_test_load,
	 //Общие интерфейсы      
     input                 clk,
     input                 arst,
	 input                 ack,
     input  [31:0]         rdata,
     output                req,
     output reg            cmd,
     output reg [31:0]     addr,
     output reg [31:0]     wdata
	 );
	 
reg [31:0] addr_reg, wdata_reg;
reg cmd_reg, req_reg, process_req_reg;

assign req = i_test_enable ? process_req_reg : req_reg;

//Запись тестовых сигналов в регистры функциональной модели
always @(posedge i_test_load) begin
 if (i_test_load) begin
  addr_reg <= i_test_addr;
  wdata_reg <= i_test_wdata;
  cmd_reg <= i_test_cmd;
  req_reg <= i_test_req;
  end
end
  

always @(posedge clk,posedge arst)
begin
  if (arst) begin
   process_req_reg <= 1'b0;
   cmd <= 1'b0;
   addr <= 0;
   wdata <= 0;
    end
	 else begin
	  if (i_test_enable) begin
	   if (req_reg) begin
	    case (cmd_reg)
		//Операция записи
		1:  
		   begin
		    addr <= addr_reg;
			wdata <= wdata_reg;
			cmd <= cmd_reg;
		   end
		//Операция чтения
		0:
		   begin
		    addr <= addr_reg;
			cmd <= cmd_reg;
		   end
		default: 
		        begin
		         addr <= 0;
			     wdata <= 0;
			     cmd <= 1'b0;
			     process_req_reg <= 1'b0;
				end
		endcase
		
		if (ack) begin
		  process_req_reg <= 1'b0; end
		  else begin
		  process_req_reg <= 1'b1; end
	end
end
end

end


endmodule