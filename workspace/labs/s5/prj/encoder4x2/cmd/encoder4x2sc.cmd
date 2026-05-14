simSetSimulator "-vcssv" -exec "./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "./simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
schCreateWindow -delim "." -win $_nSchema1 -scope "tb_encoder4x2"
verdiSetActWin -win $_nSchema_3
schSelect -win $_nSchema3 -inst "uut"
schPushViewIn -win $_nSchema3
debExit
