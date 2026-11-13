simSetSimulator "-vcssv" -exec "./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "./simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
schCreateWindow -delim "." -win $_nSchema1 -scope "adder_tb"
verdiSetActWin -win $_nSchema_3
schSelect -win $_nSchema3 -inst "dut"
schPushViewIn -win $_nSchema3
verdiSetActWin -dock widgetDock_<Message>
verdiSetActWin -win $_OneSearch
verdiSetActWin -win $_InteractiveConsole_2
verdiSetActWin -win $_nSchema_3
schSetOptions -win $_nSchema3 -portName on
schSetOptions -win $_nSchema3 -pinName on
schSetOptions -win $_nSchema3 -instName on
schSetOptions -win $_nSchema3 -detailRTL on
schFit -win $_nSchema3

