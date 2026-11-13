simSetSimulator "-vcssv" -exec "./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "./simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvCreateWindow
verdiSetActWin -win $_nWave3
srcHBDrag -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvDumpScope "updown_counter_tb.dut"
wvSetPosition -win $_nWave3 {("dut" 0)}
wvRenameGroup -win $_nWave3 {G1} {dut}
wvAddSignal -win $_nWave3 "/updown_counter_tb/dut/clk" \
           "/updown_counter_tb/dut/resetn" "/updown_counter_tb/dut/en" \
           "/updown_counter_tb/dut/up_counter\[3:0\]" \
           "/updown_counter_tb/dut/down_counter\[3:0\]"
wvSetPosition -win $_nWave3 {("dut" 0)}
wvSetPosition -win $_nWave3 {("dut" 5)}
wvSetPosition -win $_nWave3 {("dut" 5)}
srcTBRunSim
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
verdiSetActWin -win $_nWave3

