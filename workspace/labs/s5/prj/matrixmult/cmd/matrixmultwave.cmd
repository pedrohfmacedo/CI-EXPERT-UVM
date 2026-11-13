simSetSimulator "-vcssv" -exec "./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "./simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvCreateWindow
verdiSetActWin -win $_nWave3
srcHBDrag -win $_nTrace1
wvDumpScope "matrix2x2_mult_tb.dut"
wvSetPosition -win $_nWave3 {("dut" 0)}
wvRenameGroup -win $_nWave3 {G1} {dut}
wvAddSignal -win $_nWave3 "/matrix2x2_mult_tb/dut/A\[31:0\]" \
           "/matrix2x2_mult_tb/dut/B\[31:0\]" \
           "/matrix2x2_mult_tb/dut/Res\[31:0\]" "/matrix2x2_mult_tb/dut/clk" \
           "/matrix2x2_mult_tb/dut/rstn" "/matrix2x2_mult_tb/dut/en"
wvSetPosition -win $_nWave3 {("dut" 0)}
wvSetPosition -win $_nWave3 {("dut" 6)}
wvSetPosition -win $_nWave3 {("dut" 6)}
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcTBRunSim
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
verdiSetActWin -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3

