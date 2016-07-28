set_max_delay -from [get_ports {master_1_addr[*]}] -to [get_ports {slave_1_addr[*]}] 5ns
set_min_delay -from [get_ports {master_1_addr[*]}] -to [get_ports {slave_1_addr[*]}] 4ns

set_max_delay -from [get_ports {master_2_addr[*]}] -to [get_ports {slave_2_addr[*]}] 5ns
set_min_delay -from [get_ports {master_2_addr[*]}] -to [get_ports {slave_2_addr[*]}] 4ns

set_max_delay -from [get_ports {master_1_wdata[*]}] -to [get_ports {slave_1_wdata[*]}] 5ns
set_min_delay -from [get_ports {master_1_wdata[*]}] -to [get_ports {slave_1_wdata[*]}] 4ns

set_max_delay -from [get_ports {master_2_wdata[*]}] -to [get_ports {slave_2_wdata[*]}] 5ns
set_min_delay -from [get_ports {master_2_wdata[*]}] -to [get_ports {slave_2_wdata[*]}] 4ns

set_max_delay -from [get_ports {slave_1_rdata[*]}] -to [get_ports {master_1_rdata[*]}] 5ns
set_min_delay -from [get_ports {slave_1_rdata[*]}] -to [get_ports {master_1_rdata[*]}] 4ns

set_max_delay -from [get_ports {slave_2_rdata[*]}] -to [get_ports {master_2_rdata[*]}] 5ns
set_min_delay -from [get_ports {slave_2_rdata[*]}] -to [get_ports {master_2_rdata[*]}] 4ns

set_max_delay -from [get_ports {master_1_req}] -to [get_ports {slave_1_req}] 5ns
set_min_delay -from [get_ports {master_1_req}] -to [get_ports {slave_1_req}] 4ns

set_max_delay -from [get_ports {master_2_req}] -to [get_ports {slave_2_req}] 5ns
set_min_delay -from [get_ports {master_2_req}] -to [get_ports {slave_2_req}] 4ns

set_max_delay -from [get_ports {master_1_cmd}] -to [get_ports {slave_1_cmd}] 5ns
set_min_delay -from [get_ports {master_1_cmd}] -to [get_ports {slave_1_cmd}] 4ns

set_max_delay -from [get_ports {master_2_cmd}] -to [get_ports {slave_2_cmd}] 5ns
set_min_delay -from [get_ports {master_2_cmd}] -to [get_ports {slave_2_cmd}] 4ns

set_max_delay -from [get_ports {slave_1_ack}] -to [get_ports {master_1_ack}] 5ns
set_min_delay -from [get_ports {slave_1_ack}] -to [get_ports {master_1_ack}] 4ns

set_max_delay -from [get_ports {slave_2_ack}] -to [get_ports {master_2_ack}] 5ns
set_min_delay -from [get_ports {slave_2_ack}] -to [get_ports {master_2_ack}] 4ns
