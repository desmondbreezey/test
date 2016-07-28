module test_top_level
(
//Общие входы
input          clk,
input          arst,
input          enable, //Разрешение на выполнение операций согласно функциональному описанию
input          load,   //Разрешение на загрузку новых тестовых векторов
//Входы для загрузки тестовых векторов 1-ого мастера
input   [31:0] i_test_master_1_addr,
input   [31:0] i_test_master_1_wdata,
input          i_test_master_1_cmd,
input          i_test_master_1_req,
//Входы для загрузки тестовых векторов 2-ого мастера
input   [31:0] i_test_master_2_addr,
input   [31:0] i_test_master_2_wdata,
input          i_test_master_2_cmd,
input          i_test_master_2_req,
//Отладочные выводы
output         o_cb_m_ack_1,
output         o_cb_m_ack_2,
output         o_m_cb_req_1,
output         o_m_cb_req_2,
output         o_m_cb_cmd_1,
output         o_m_cb_cmd_2,
output         o_s_cb_ack_1,
output         o_s_cb_ack_2,
output         o_cb_s_cmd_1,
output         o_cb_s_cmd_2,
output         o_cb_s_req_1,
output         o_cb_s_req_2,
output  [31:0] o_cb_m_rdata_1,
output  [31:0] o_cb_m_rdata_2,
output  [31:0] o_m_cb_addr_1,
output  [31:0] o_m_cb_addr_2,
output  [31:0] o_m_cb_wdata_1,
output  [31:0] o_m_cb_wdata_2,
output  [31:0] o_s_cb_rdata_1,
output  [31:0] o_s_cb_rdata_2,
output  [31:0] o_cb_s_addr_1,
output  [31:0] o_cb_s_addr_2,
output  [31:0] o_cb_s_wdata_1,
output  [31:0] o_cb_s_wdata_2
);

/*
Префиксы:
m_cb - от мастера к коммутатору
cb_s - от коммутатора к слэйву
s_cb - от слэйва к коммутатору
cb_m - от коммутатора к мастеру
*/

//Соединения для 1-ого мастера
wire         cb_m_ack_1;
wire  [31:0] cb_m_rdata_1;
wire         m_cb_req_1;
wire         m_cb_cmd_1;
wire  [31:0] m_cb_addr_1;
wire  [31:0] m_cb_wdata_1;
//Соединения для 2-ого мастера
wire         cb_m_ack_2;
wire  [31:0] cb_m_rdata_2;
wire         m_cb_req_2;
wire         m_cb_cmd_2;
wire  [31:0] m_cb_addr_2;
wire  [31:0] m_cb_wdata_2;
//Соединения для 1-ого слэйва
wire         s_cb_ack_1;
wire  [31:0] s_cb_rdata_1;
wire         cb_s_cmd_1;
wire         cb_s_req_1;
wire  [31:0] cb_s_addr_1;
wire  [31:0] cb_s_wdata_1;
//Соединения для 2-ого слэйва
wire         s_cb_ack_2;
wire  [31:0] s_cb_rdata_2;
wire         cb_s_cmd_2;
wire         cb_s_req_2;
wire  [31:0] cb_s_addr_2;
wire  [31:0] cb_s_wdata_2;

//Назначения для отладочных выводов
assign o_cb_m_ack_1 = cb_m_ack_1;
assign o_cb_m_ack_2 = cb_m_ack_2;
assign o_m_cb_req_1 = m_cb_req_1;
assign o_m_cb_req_2 = m_cb_req_2;
assign o_m_cb_cmd_1 = m_cb_cmd_1;
assign o_m_cb_cmd_2 = m_cb_cmd_2;
assign o_s_cb_ack_1 = s_cb_ack_1;
assign o_s_cb_ack_2 = s_cb_ack_2;
assign o_cb_s_cmd_1 = cb_s_cmd_1;
assign o_cb_s_cmd_2 = cb_s_cmd_2;
assign o_cb_s_req_1 = cb_s_req_1;
assign o_cb_s_req_2 = cb_s_req_2;
assign o_cb_m_rdata_1 = cb_m_rdata_1;
assign o_cb_m_rdata_2 = cb_m_rdata_2;
assign o_m_cb_addr_1 = m_cb_addr_1;
assign o_m_cb_addr_2 = m_cb_addr_2;
assign o_m_cb_wdata_1 = m_cb_wdata_1;
assign o_m_cb_wdata_2 = m_cb_wdata_2;
assign o_s_cb_rdata_1 = s_cb_rdata_1;
assign o_s_cb_rdata_2 = s_cb_rdata_2;
assign o_cb_s_addr_1 = cb_s_addr_1;
assign o_cb_s_addr_2 = cb_s_addr_2;
assign o_cb_s_wdata_1 = cb_s_wdata_1;
assign o_cb_s_wdata_2 = cb_s_wdata_2;

//Подключение модулей
master unit_master_1
(
.clk            (clk),
.arst           (arst),
.ack            (cb_m_ack_1),
.rdata          (cb_m_rdata_1),
.req            (m_cb_req_1),
.cmd            (m_cb_cmd_1),
.addr           (m_cb_addr_1),
.wdata          (m_cb_wdata_1),
.i_test_addr    (i_test_master_1_addr),
.i_test_wdata   (i_test_master_1_wdata),
.i_test_cmd     (i_test_master_1_cmd),
.i_test_req     (i_test_master_1_req),
.i_test_enable  (enable),
.i_test_load    (load)
);


master unit_master_2
(
.clk            (clk),
.arst           (arst),
.ack            (cb_m_ack_2),
.rdata          (cb_m_rdata_2),
.req            (m_cb_req_2),
.cmd            (m_cb_cmd_2),
.addr           (m_cb_addr_2),
.wdata          (m_cb_wdata_2),
.i_test_addr    (i_test_master_2_addr),
.i_test_wdata   (i_test_master_2_wdata),
.i_test_cmd     (i_test_master_2_cmd),
.i_test_req     (i_test_master_2_req),
.i_test_enable  (enable),
.i_test_load    (load)
);


crossbar unit_crossbar
(
.master_1_req   (m_cb_req_1),
.master_2_req   (m_cb_req_2),
.master_1_cmd   (m_cb_cmd_1),
.master_2_cmd   (m_cb_cmd_2),
.slave_1_ack    (s_cb_ack_1),
.slave_2_ack    (s_cb_ack_2),
.master_1_addr  (m_cb_addr_1),
.master_2_addr  (m_cb_addr_2),
.master_1_wdata (m_cb_wdata_1),
.master_2_wdata (m_cb_wdata_2),
.slave_1_rdata  (s_cb_rdata_1),
.slave_2_rdata  (s_cb_rdata_2),
.slave_1_req    (cb_s_req_1),
.slave_2_req    (cb_s_req_2),
.slave_1_cmd    (cb_s_cmd_1),
.slave_2_cmd    (cb_s_cmd_2),
.master_1_ack   (cb_m_ack_1),
.master_2_ack   (cb_m_ack_2),
.slave_1_addr   (cb_s_addr_1),
.slave_2_addr   (cb_s_addr_2),
.master_1_rdata (cb_m_rdata_1),
.master_2_rdata (cb_m_rdata_2),
.slave_1_wdata  (cb_s_wdata_1),
.slave_2_wdata  (cb_s_wdata_2)
);


slave unit_slave_1
(
.clk            (clk),
.arst           (arst),
.cmd            (cb_s_cmd_1),
.req            (cb_s_req_1),
.addr           (cb_s_addr_1),
.wdata          (cb_s_wdata_1),
.ack            (s_cb_ack_1),
.rdata          (s_cb_rdata_1)
);

slave unit_slave_2
(
.clk            (clk),
.arst           (arst),
.cmd            (cb_s_cmd_2),
.req            (cb_s_req_2),
.addr           (cb_s_addr_2),
.wdata          (cb_s_wdata_2),
.ack            (s_cb_ack_2),
.rdata          (s_cb_rdata_2)
);


endmodule