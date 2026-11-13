simSetSimulator "-vcssv" -exec "./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "./simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvCreateWindow
verdiSetActWin -win $_nWave3
srcHBDrag -win $_nTrace1
wvDumpScope "counter_overflow_tb.dut"
wvSetPosition -win $_nWave3 {("dut" 0)}
wvRenameGroup -win $_nWave3 {G1} {dut}
wvAddSignal -win $_nWave3 "/counter_overflow_tb/dut/clk" \
           "/counter_overflow_tb/dut/reset_n" "/counter_overflow_tb/dut/en" \
           "/counter_overflow_tb/dut/load" \
           "/counter_overflow_tb/dut/counter_out\[31:0\]" \
           "/counter_overflow_tb/dut/counter_overflow"
wvSetPosition -win $_nWave3 {("dut" 0)}
wvSetPosition -win $_nWave3 {("dut" 6)}
wvSetPosition -win $_nWave3 {("dut" 6)}
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcTBRunSim
verdiSetActWin -dock widgetDock_<Watch>
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomIn -win $_nWave3
verdiSetActWin -win $_nWave3
wvZoomIn -win $_nWave3

