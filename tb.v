`timescale 1ns/1ns

`define CLK_PERIOD 20 //Период тактовой частоты 20 нс (50 МГц)

module tb;

//Регистры тактового сигнала и сигнала сброса
reg test_clk = 1'b0;
reg test_arst = 1'b0;

initial forever #(`CLK_PERIOD/2) test_clk <= ~test_clk; //Задали тактовый сигнал
//Регистры для чтения из файла тестовых векторов
reg [31:0] registers [0:7];

//Регистры для записи тестовых векторов из тестбенча в модуль мастера
//Общие регистры
reg        enable;
reg        load;
//Регистры первого мастера
reg        m_1_req;
reg        m_1_cmd;
reg [31:0] m_1_addr;
reg [31:0] m_1_wdata;
//Регистры второго мастера
reg        m_2_req;
reg        m_2_cmd;
reg [31:0] m_2_addr;
reg [31:0] m_2_wdata;

//Вывод отладочных сигналов
//Соединения для 1-ого мастера
wire         o_cb_m_ack_1;
wire  [31:0] o_cb_m_rdata_1;
wire         o_m_cb_req_1;
wire         o_m_cb_cmd_1;
wire  [31:0] o_m_cb_addr_1;
wire  [31:0] o_m_cb_wdata_1;
//Соединения для 2-ого мастера
wire         o_cb_m_ack_2;
wire  [31:0] o_cb_m_rdata_2;
wire         o_m_cb_req_2;
wire         o_m_cb_cmd_2;
wire  [31:0] o_m_cb_addr_2;
wire  [31:0] o_m_cb_wdata_2;
//Соединения для 1-ого слэйва
wire         o_s_cb_ack_1;
wire  [31:0] o_s_cb_rdata_1;
wire         o_cb_s_cmd_1;
wire         o_cb_s_req_1;
wire  [31:0] o_cb_s_addr_1;
wire  [31:0] o_cb_s_wdata_1;
//Соединения для 2-ого слэйва
wire         o_s_cb_ack_2;
wire  [31:0] o_s_cb_rdata_2;
wire         o_cb_s_cmd_2;
wire         o_cb_s_req_2;
wire  [31:0] o_cb_s_addr_2;
wire  [31:0] o_cb_s_wdata_2;

//подключение тестового модуля
test_top_level uut
(
.clk                     (test_clk),
.arst                    (test_arst),
.enable                  (enable),
.load                    (load),
.i_test_master_1_addr    (m_1_addr),
.i_test_master_1_wdata   (m_1_wdata),
.i_test_master_1_cmd     (m_1_cmd),
.i_test_master_1_req     (m_1_req),
.i_test_master_2_addr    (m_2_addr),
.i_test_master_2_wdata   (m_2_wdata),
.i_test_master_2_cmd     (m_2_cmd),
.i_test_master_2_req     (m_2_req),
.o_cb_m_ack_1            (o_cb_m_ack_1),
.o_cb_m_ack_2            (o_cb_m_ack_2),
.o_m_cb_req_1            (o_m_cb_req_1),
.o_m_cb_req_2            (o_m_cb_req_2),
.o_m_cb_cmd_1            (o_m_cb_cmd_1),
.o_m_cb_cmd_2            (o_m_cb_cmd_2),
.o_s_cb_ack_1            (o_s_cb_ack_1),
.o_s_cb_ack_2            (o_s_cb_ack_2),
.o_cb_s_cmd_1            (o_cb_s_cmd_1),
.o_cb_s_cmd_2            (o_cb_s_cmd_2),
.o_cb_s_req_1            (o_cb_s_req_1),
.o_cb_s_req_2            (o_cb_s_req_2),
.o_cb_m_rdata_1          (o_cb_m_rdata_1),
.o_cb_m_rdata_2          (o_cb_m_rdata_2),
.o_m_cb_addr_1           (o_m_cb_addr_1),
.o_m_cb_addr_2           (o_m_cb_addr_2),
.o_m_cb_wdata_1          (o_m_cb_wdata_1),
.o_m_cb_wdata_2          (o_m_cb_wdata_2),
.o_s_cb_rdata_1          (o_s_cb_rdata_1),
.o_s_cb_rdata_2          (o_s_cb_rdata_2),
.o_cb_s_addr_1           (o_cb_s_addr_1),
.o_cb_s_addr_2           (o_cb_s_addr_2),
.o_cb_s_wdata_1          (o_cb_s_wdata_1),
.o_cb_s_wdata_2          (o_cb_s_wdata_2)
);

//Регистры для работы с файлом
integer number_file;
integer i;
integer inc = 0;

initial begin
//Открыть для чтения файл с тестовыми векторами
number_file = $fopen("test_vectors.txt", "r"); 
//Ошибка, если файл не удалось открыть
if (number_file == 0) begin
      $display("Error: Failed to open file, test_vectors.txt\n Exiting Simulation.");	  
      $finish;
end
//прочитали 1-й набор тестовых векторов для 1-ого мастера 
for(inc = 0; inc < 8; inc = inc + 1) begin 
     i = $fscanf(number_file, "%b\n", registers[inc]);
end	
//записываем значения 1-ого набора тестовых векторов для 1-ого мастера в регистры мастера
m_1_req = registers[0][0];
m_1_cmd = registers[1][0];
m_1_addr = registers[2];
m_1_wdata = registers[3];
m_2_req = registers[4][0];
m_2_cmd = registers[5][0];
m_2_addr = registers[6];
m_2_wdata = registers[7];
#(100); //ждем 100 нс
load = 1'b1;
#(`CLK_PERIOD);
test_arst = 1'b1;
#(`CLK_PERIOD);
test_arst = 1'b0;
enable = 1'b1;
#(`CLK_PERIOD*3);
m_1_req <= 1'b0;
m_2_req <= 1'b0;
load = 1'b0;
enable = 1'b0;
#(`CLK_PERIOD*4);
for(inc = 8; inc < 16; inc = inc + 1) begin 
     i = $fscanf(number_file, "%b\n", registers[inc-8]);
end	
m_1_req = registers[0][0];
m_1_cmd = registers[1][0];
m_1_addr = registers[2];
m_1_wdata = registers[3];
m_2_req = registers[4][0];
m_2_cmd = registers[5][0];
m_2_addr = registers[6];
m_2_wdata = registers[7];
load = 1'b1;
enable = 1'b1;
#(`CLK_PERIOD*3);
m_1_req <= 1'b0;
m_2_req <= 1'b0;
load = 1'b0;
enable = 1'b0;
#(`CLK_PERIOD*4);
for(inc = 16; inc < 24; inc = inc + 1) begin 
     i = $fscanf(number_file, "%b\n", registers[inc-16]);
end	
m_1_req = registers[0][0];
m_1_cmd = registers[1][0];
m_1_addr = registers[2];
m_1_wdata = registers[3];
m_2_req = registers[4][0];
m_2_cmd = registers[5][0];
m_2_addr = registers[6];
m_2_wdata = registers[7];
load = 1'b1;
enable = 1'b1;
#(`CLK_PERIOD*6);
$fclose(number_file);
$display("That's all");
$stop;
end


endmodule

