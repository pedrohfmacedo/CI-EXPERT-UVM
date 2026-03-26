simSetSimulator "-vcssv" -exec "./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "./simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiWindowResize -win $_Verdi_1 "92" "200" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvCreateWindow
verdiSetActWin -win $_nWave3
wvSelectGroup -win $_nWave3 {G1}
wvSelectGroup -win $_nWave3 {G1}
wvSelectGroup -win $_nWave3 {G1}
wvSelectGroup -win $_nWave3 {G1}
wvSelectGroup -win $_nWave3 {G1}
wvSelectGroup -win $_nWave3 {G1}
wvSelectGroup -win $_nWave3 {G1}
wvSelectGroup -win $_nWave3 {G1}
srcTBRunSim
wvSelectGroup -win $_nWave3 {G1}
wvSelectGroup -win $_nWave3 {G1}
wvGetSignalOpen -win $_nWave3
wvGetSignalSetScope -win $_nWave3 "/calc4_tb"
debExit
