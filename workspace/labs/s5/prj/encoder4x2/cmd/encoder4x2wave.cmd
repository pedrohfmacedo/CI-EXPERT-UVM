simSetSimulator "-vcssv" -exec "./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "./simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvCreateWindow
verdiSetActWin -win $_nWave3
srcHBDrag -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvDumpScope "tb_encoder4x2.uut"
wvSetPosition -win $_nWave3 {("uut" 0)}
wvRenameGroup -win $_nWave3 {G1} {uut}
wvAddSignal -win $_nWave3 "/tb_encoder4x2/uut/din\[3:0\]" \
           "/tb_encoder4x2/uut/clk" "/tb_encoder4x2/uut/dout\[1:0\]" \
           "/tb_encoder4x2/uut/rstn" "/tb_encoder4x2/uut/en"
wvSetPosition -win $_nWave3 {("uut" 0)}
wvSetPosition -win $_nWave3 {("uut" 5)}
wvSetPosition -win $_nWave3 {("uut" 5)}
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
