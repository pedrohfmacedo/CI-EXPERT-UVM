simSetSimulator "-vcssv" -exec "./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "./simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiWindowResize -win $_Verdi_1 "510" "134" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
schCreateWindow -win $_nSchema1 -hierFlatten
verdiSetActWin -win $_nSchema_3
schCreateWindow -delim "." -win $_nSchema1 -scope "demux1x8_tb"
verdiSetActWin -win $_nSchema_4
schZoom {19013} {-4604} {19253} {-3525} -win $_nSchema4
