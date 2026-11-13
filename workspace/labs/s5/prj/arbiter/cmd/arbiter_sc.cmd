simSetSimulator "-vcssv" -exec "./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "./simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
schCreateWindow -win $_nSchema1 -hierFlatten
verdiSetActWin -win $_nSchema_3
schCreateWindow -delim "." -win $_nSchema1 -scope "tb_arbiter"
verdiSetActWin -win $_nSchema_4
