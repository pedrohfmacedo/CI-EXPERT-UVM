simSetSimulator "-vcssv" -exec "./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "./simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiWindowResize -win $_Verdi_1 "510" "162" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvCreateWindow
verdiSetActWin -win $_nWave3
wvCreateWindow
verdiSetActWin -win $_nWave4
wvSetPosition -win $_nWave4 {("G1" 0)}
wvOpenFile -win $_nWave4 \
           {/home/xmen-aluno/CI-EXPERT-UVM/workspace/labs/s5/prj/1x8demux/demux1x8.fsdb}
srcHBSelect "demux1x8_tb.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvDumpScope "demux1x8_tb.dut"
wvSetPosition -win $_nWave4 {("dut" 0)}
wvRenameGroup -win $_nWave4 {G1} {dut}
wvAddSignal -win $_nWave4 "/demux1x8_tb/dut/clk" "/demux1x8_tb/dut/rstn" \
           "/demux1x8_tb/dut/en" "/demux1x8_tb/dut/sel\[2:0\]" \
           "/demux1x8_tb/dut/din" "/demux1x8_tb/dut/dout\[7:0\]"
wvSetPosition -win $_nWave4 {("dut" 0)}
wvSetPosition -win $_nWave4 {("dut" 6)}
wvSetPosition -win $_nWave4 {("dut" 6)}
wvZoomIn -win $_nWave4
wvScrollDown -win $_nWave4 0
verdiSetActWin -win $_nWave4

