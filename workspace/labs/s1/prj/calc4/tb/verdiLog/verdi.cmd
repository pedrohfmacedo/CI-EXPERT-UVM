wvCreateWindow
wvSetPosition -win $_nWave2 {("G1" 0)}
wvOpenFile -win $_nWave2 \
           {/home/pedro.macedo/CI-EXPERT-UVM/workspace/labs/s1/prj/calc4/rtl/wave.fsdb}
verdiSetActWin -win $_nWave2
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
debExit
