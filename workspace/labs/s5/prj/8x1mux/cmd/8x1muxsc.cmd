simSetSimulator "-vcssv" -exec "./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "./simv.daidir"
srcTBInvokeSim
verdiDockWidgetDisplay -dock windowDock_InteractiveConsole_2
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvCreateWindow
schCreateWindow -win $_nSchema1 -hierFlatten
verdiSetActWin -win $_nSchema_4
schCreateWindow -delim "." -win $_nSchema1 -scope "tb_mux8x1"
verdiSetActWin -win $_nSchema_5
schSelect -win $_nSchema5 -inst "dut"
schPushViewIn -win $_nSchema5
schZoomOut -win $_nSchema5
schZoom {-1721} {-3596} {16811} {15171} -win $_nSchema5
schFit -win $_nSchema5
schSetOptions -win $_nSchema5 -portName on
schSetOptions -win $_nSchema5 -pinName on
schSetOptions -win $_nSchema5 -instName on
schSetOptions -win $_nSchema5 -completeName on
schSetOptions -win $_nSchema5 -localNetName on
schSetOptions -win $_nSchema5 -detailRTL on

