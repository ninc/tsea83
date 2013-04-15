onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /lab_tb/clk
add wave -noupdate -format Logic /lab_tb/rst
add wave -noupdate -format Logic /lab_tb/rx
add wave -noupdate -format Literal /lab_tb/seg
add wave -noupdate -format Literal /lab_tb/an
add wave -noupdate -format Logic /lab_tb/tb_running
add wave -noupdate -format Literal /lab_tb/rxs
add wave -noupdate -format Logic /lab_tb/uut/clk
add wave -noupdate -format Logic /lab_tb/uut/rst
add wave -noupdate -format Logic /lab_tb/uut/rx
add wave -noupdate -format Literal /lab_tb/uut/seg
add wave -noupdate -format Literal /lab_tb/uut/an
add wave -noupdate -format Literal -radix unsigned /lab_tb/uut/clk_cnt
add wave -noupdate -format Literal -radix unsigned /lab_tb/uut/bit_cnt
add wave -noupdate -format Literal /lab_tb/uut/sreg
add wave -noupdate -format Literal /lab_tb/uut/tal
add wave -noupdate -format Logic /lab_tb/uut/rx1
add wave -noupdate -format Logic /lab_tb/uut/rx2
add wave -noupdate -format Logic /lab_tb/uut/sp
add wave -noupdate -format Logic /lab_tb/uut/lp
add wave -noupdate -format Literal /lab_tb/uut/pos
add wave -noupdate -format Logic /lab_tb/uut/in_idle
add wave -noupdate -format Logic /lab_tb/uut/led/clk
add wave -noupdate -format Logic /lab_tb/uut/led/rst
add wave -noupdate -format Literal /lab_tb/uut/led/seg
add wave -noupdate -format Literal /lab_tb/uut/led/an
add wave -noupdate -format Literal /lab_tb/uut/led/value
add wave -noupdate -format Literal /lab_tb/uut/led/segments
add wave -noupdate -format Literal /lab_tb/uut/led/counter_r
add wave -noupdate -format Literal /lab_tb/uut/led/v
add wave -noupdate -format Logic /lab_tb/uut/led/dp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {257506 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {196875 ns} {328125 ns}
