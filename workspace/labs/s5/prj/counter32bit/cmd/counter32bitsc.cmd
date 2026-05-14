simSetSimulator "-vcssv" -exec "./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "./simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
schCreateWindow -delim "." -win $_nSchema1 -scope "counter_overflow_tb"
verdiSetActWin -win $_nSchema_3
schSelect -win $_nSchema3 -inst "dut"
schPushViewIn -win $_nSchema3
schSetOptions -win $_nSchema3 -pinName on
schSetOptions -win $_nSchema3 -portName on
schSetOptions -win $_nSchema3 -instName on
schSetOptions -win $_nSchema3 -localNetName on
schSetOptions -win $_nSchema3 -stickyLocator on
schSetOptions -win $_nSchema3 -detailRTL on

