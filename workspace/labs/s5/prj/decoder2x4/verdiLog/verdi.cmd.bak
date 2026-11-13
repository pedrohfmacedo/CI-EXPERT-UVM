simSetSimulator "-vcssv" -exec "./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "./simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
wvCreateWindow
verdiSetActWin -win $_nWave3
srcHBDrag -win $_nTrace1
wvDumpScope "decoder2x4_tb.dut"
wvSetPosition -win $_nWave3 {("dut" 0)}
wvRenameGroup -win $_nWave3 {G1} {dut}
wvAddSignal -win $_nWave3 "/decoder2x4_tb/dut/clk" "/decoder2x4_tb/dut/rstn" \
           "/decoder2x4_tb/dut/en" "/decoder2x4_tb/dut/din\[1:0\]" \
           "/decoder2x4_tb/dut/dout\[3:0\]"
wvSetPosition -win $_nWave3 {("dut" 0)}
wvSetPosition -win $_nWave3 {("dut" 5)}
wvSetPosition -win $_nWave3 {("dut" 5)}
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcTBRunSim
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
debExit
