wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 {/home/wzc/verilog/systolic_array/tb_PE.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/tb_PE"
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb_PE/RECEIVE_en\[31:0\]} \
{/tb_PE/activation_in\[15:0\]} \
{/tb_PE/clk} \
{/tb_PE/reg_partial_sum\[15:0\]} \
{/tb_PE/rst} \
{/tb_PE/weight_en} \
{/tb_PE/weight_in\[15:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 )} 
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSetPosition -win $_nWave1 {("G1" 8)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb_PE/RECEIVE_en\[31:0\]} \
{/tb_PE/activation_in\[15:0\]} \
{/tb_PE/clk} \
{/tb_PE/reg_partial_sum\[15:0\]} \
{/tb_PE/rst} \
{/tb_PE/weight_en} \
{/tb_PE/weight_in\[15:0\]} \
{/tb_PE/input_en\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSetPosition -win $_nWave1 {("G1" 8)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb_PE/RECEIVE_en\[31:0\]} \
{/tb_PE/activation_in\[15:0\]} \
{/tb_PE/clk} \
{/tb_PE/reg_partial_sum\[15:0\]} \
{/tb_PE/rst} \
{/tb_PE/weight_en} \
{/tb_PE/weight_in\[15:0\]} \
{/tb_PE/input_en\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetPosition -win $_nWave1 {("G1" 8)}
wvGetSignalClose -win $_nWave1
wvResizeWindow -win $_nWave1 296 433 1386 332
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvSetCursor -win $_nWave1 40028.117155 -snap {("G1" 1)}
wvResizeWindow -win $_nWave1 296 433 1386 332
wvResizeWindow -win $_nWave1 296 433 1386 332
wvSetCursor -win $_nWave1 10284.290895 -snap {("G1" 5)}
wvSetCursor -win $_nWave1 20027.303322 -snap {("G1" 5)}
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/tb_PE"
wvGetSignalSetScope -win $_nWave1 "/tb_PE"
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb_PE/RECEIVE_en\[31:0\]} \
{/tb_PE/activation_in\[15:0\]} \
{/tb_PE/clk} \
{/tb_PE/reg_partial_sum\[15:0\]} \
{/tb_PE/rst} \
{/tb_PE/weight_en} \
{/tb_PE/weight_in\[15:0\]} \
{/tb_PE/input_en\[31:0\]} \
{/tb_PE/reg_weight\[15:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb_PE/RECEIVE_en\[31:0\]} \
{/tb_PE/activation_in\[15:0\]} \
{/tb_PE/clk} \
{/tb_PE/reg_partial_sum\[15:0\]} \
{/tb_PE/rst} \
{/tb_PE/weight_en} \
{/tb_PE/weight_in\[15:0\]} \
{/tb_PE/input_en\[31:0\]} \
{/tb_PE/reg_weight\[15:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSetPosition -win $_nWave1 {("G1" 9)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 25846.046855 -snap {("G1" 9)}
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetCursor -win $_nWave1 30311.594218 -snap {("G1" 8)}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetCursor -win $_nWave1 35047.780814 -snap {("G1" 3)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/tb_PE"
wvGetSignalSetScope -win $_nWave1 "/tb_PE"
wvSetPosition -win $_nWave1 {("G1" 10)}
wvSetPosition -win $_nWave1 {("G1" 10)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb_PE/RECEIVE_en\[31:0\]} \
{/tb_PE/activation_in\[15:0\]} \
{/tb_PE/clk} \
{/tb_PE/reg_partial_sum\[15:0\]} \
{/tb_PE/rst} \
{/tb_PE/weight_en} \
{/tb_PE/weight_in\[15:0\]} \
{/tb_PE/input_en\[31:0\]} \
{/tb_PE/reg_weight\[15:0\]} \
{/tb_PE/RECEIVE_en\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSetPosition -win $_nWave1 {("G1" 10)}
wvSetPosition -win $_nWave1 {("G1" 10)}
wvSetPosition -win $_nWave1 {("G1" 10)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb_PE/RECEIVE_en\[31:0\]} \
{/tb_PE/activation_in\[15:0\]} \
{/tb_PE/clk} \
{/tb_PE/reg_partial_sum\[15:0\]} \
{/tb_PE/rst} \
{/tb_PE/weight_en} \
{/tb_PE/weight_in\[15:0\]} \
{/tb_PE/input_en\[31:0\]} \
{/tb_PE/reg_weight\[15:0\]} \
{/tb_PE/RECEIVE_en\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSetPosition -win $_nWave1 {("G1" 10)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 60352.549201 -snap {("G1" 10)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/tb_PE"
wvGetSignalSetScope -win $_nWave1 "/tb_PE"
wvSetPosition -win $_nWave1 {("G1" 11)}
wvSetPosition -win $_nWave1 {("G1" 11)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb_PE/RECEIVE_en\[31:0\]} \
{/tb_PE/activation_in\[15:0\]} \
{/tb_PE/clk} \
{/tb_PE/reg_partial_sum\[15:0\]} \
{/tb_PE/rst} \
{/tb_PE/weight_en} \
{/tb_PE/weight_in\[15:0\]} \
{/tb_PE/input_en\[31:0\]} \
{/tb_PE/reg_weight\[15:0\]} \
{/tb_PE/RECEIVE_en\[31:0\]} \
{/tb_PE/j\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 11 )} 
wvSetPosition -win $_nWave1 {("G1" 11)}
wvSetPosition -win $_nWave1 {("G1" 11)}
wvSetPosition -win $_nWave1 {("G1" 11)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb_PE/RECEIVE_en\[31:0\]} \
{/tb_PE/activation_in\[15:0\]} \
{/tb_PE/clk} \
{/tb_PE/reg_partial_sum\[15:0\]} \
{/tb_PE/rst} \
{/tb_PE/weight_en} \
{/tb_PE/weight_in\[15:0\]} \
{/tb_PE/input_en\[31:0\]} \
{/tb_PE/reg_weight\[15:0\]} \
{/tb_PE/RECEIVE_en\[31:0\]} \
{/tb_PE/j\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 11 )} 
wvSetPosition -win $_nWave1 {("G1" 11)}
wvGetSignalClose -win $_nWave1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSelectSignal -win $_nWave1 {( "G1" 11 )} 
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSetCursor -win $_nWave1 64682.776947 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 59405.311882 -snap {("G1" 3)}
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetCursor -win $_nWave1 30311.594218 -snap {("G1" 8)}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSetCursor -win $_nWave1 40189.926262 -snap {("G1" 7)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/tb_PE"
wvGetSignalSetScope -win $_nWave1 "/tb_PE"
wvSetPosition -win $_nWave1 {("G1" 12)}
wvSetPosition -win $_nWave1 {("G1" 12)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb_PE/RECEIVE_en\[31:0\]} \
{/tb_PE/activation_in\[15:0\]} \
{/tb_PE/clk} \
{/tb_PE/reg_partial_sum\[15:0\]} \
{/tb_PE/rst} \
{/tb_PE/weight_en} \
{/tb_PE/weight_in\[15:0\]} \
{/tb_PE/input_en\[31:0\]} \
{/tb_PE/reg_weight\[15:0\]} \
{/tb_PE/RECEIVE_en\[31:0\]} \
{/tb_PE/j\[31:0\]} \
{/tb_PE/i\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 12 )} 
wvSetPosition -win $_nWave1 {("G1" 12)}
wvSetPosition -win $_nWave1 {("G1" 12)}
wvSetPosition -win $_nWave1 {("G1" 12)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/tb_PE/RECEIVE_en\[31:0\]} \
{/tb_PE/activation_in\[15:0\]} \
{/tb_PE/clk} \
{/tb_PE/reg_partial_sum\[15:0\]} \
{/tb_PE/rst} \
{/tb_PE/weight_en} \
{/tb_PE/weight_in\[15:0\]} \
{/tb_PE/input_en\[31:0\]} \
{/tb_PE/reg_weight\[15:0\]} \
{/tb_PE/RECEIVE_en\[31:0\]} \
{/tb_PE/j\[31:0\]} \
{/tb_PE/i\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 12 )} 
wvSetPosition -win $_nWave1 {("G1" 12)}
wvGetSignalClose -win $_nWave1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvResizeWindow -win $_nWave1 439 154 1386 468
wvSetCursor -win $_nWave1 75373.026693 -snap {("G1" 12)}
wvSetCursor -win $_nWave1 64818.096564 -snap {("G1" 12)}
wvSetCursor -win $_nWave1 54804.444902 -snap {("G1" 12)}
wvSetCursor -win $_nWave1 45196.752092 -snap {("G1" 3)}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetCursor -win $_nWave1 29634.996132 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 34777.141580 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 39783.967411 -snap {("G1" 12)}
wvSetCursor -win $_nWave1 102572.269719 -snap {("G2" 0)}
wvSetCursor -win $_nWave1 40054.606645 -snap {("G1" 12)}
wvSetCursor -win $_nWave1 44926.112858 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 54533.805668 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 65630.014266 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 74967.067842 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 45873.350178 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 30040.954984 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 19756.664088 -snap {("G1" 6)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 59811.270733 -snap {("G1" 7)}
wvSetCursor -win $_nWave1 25440.088004 -snap {("G1" 9)}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSetCursor -win $_nWave1 20162.622939 -snap {("G1" 6)}
wvSetCursor -win $_nWave1 24898.809536 -snap {("G1" 12)}
wvSetCursor -win $_nWave1 35318.420048 -snap {("G1" 12)}
wvSetCursor -win $_nWave1 45196.752092 -snap {("G1" 12)}
wvSetCursor -win $_nWave1 20433.262174 -snap {("G1" 12)}
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSetRadix -win $_nWave1 -2Com
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetCursor -win $_nWave1 83086.244864 -snap {("G2" 0)}
wvSetCursor -win $_nWave1 20297.942556 -snap {("G1" 7)}
wvSetCursor -win $_nWave1 84033.482184 -snap {("G2" 0)}
wvSetCursor -win $_nWave1 25034.129153 -snap {("G1" 9)}
wvSetCursor -win $_nWave1 19756.664088 -snap {("G1" 12)}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSetCursor -win $_nWave1 136266.854362 -snap {("G2" 0)}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSetCursor -win $_nWave1 8660.455491 -snap {("G2" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 25034.129153 -snap {("G1" 12)}
wvSetCursor -win $_nWave1 44926.112858 -snap {("G1" 12)}
wvSetCursor -win $_nWave1 25710.727238 -snap {("G1" 12)}
wvSetCursor -win $_nWave1 19756.664088 -snap {("G1" 3)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 30176.274601 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 35589.059282 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 39648.647794 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 20162.622939 -snap {("G1" 3)}
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSetCursor -win $_nWave1 25169.448770 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 35183.100431 -snap {("G1" 3)}
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSetCursor -win $_nWave1 20027.303322 -snap {("G1" 7)}
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSetCursor -win $_nWave1 35047.780814 -snap {("G1" 4)}
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetCursor -win $_nWave1 29696.485062 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 39885.237258 -snap {("G1" 3)}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSetCursor -win $_nWave1 29696.485062 -snap {("G1" 8)}
wvSelectSignal -win $_nWave1 {( "G1" 12 )} 
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G2" 0)}
wvSetPosition -win $_nWave1 {("G1" 11)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 40009.490334 -snap {("G1" 2)}
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSelectSignal -win $_nWave1 {( "G1" 11 )} 
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvSetCursor -win $_nWave1 19756.239016 -snap {("G1" 5)}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G2" 0)}
wvSetPosition -win $_nWave1 {("G1" 10)}
wvSetCursor -win $_nWave1 29944.991213 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 19507.732865 -snap {("G1" 2)}
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvSetCursor -win $_nWave1 19756.239016 -snap {("G1" 5)}
wvSetCursor -win $_nWave1 19756.239016 -snap {("G1" 4)}
wvSetCursor -win $_nWave1 20004.745167 -snap {("G1" 5)}
wvSetCursor -win $_nWave1 24974.868190 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 40382.249561 -snap {("G1" 10)}
wvSetCursor -win $_nWave1 50198.242531 -snap {("G1" 10)}
wvSetCursor -win $_nWave1 60138.488576 -snap {("G1" 10)}
wvSetCursor -win $_nWave1 30690.509666 -snap {("G1" 9)}
wvSetCursor -win $_nWave1 29696.485062 -snap {("G1" 10)}
wvSetCursor -win $_nWave1 49576.977153 -snap {("G1" 9)}
wvSetCursor -win $_nWave1 59765.729350 -snap {("G1" 9)}
wvSetCursor -win $_nWave1 70451.493849 -snap {("G1" 9)}
wvSetCursor -win $_nWave1 80640.246046 -snap {("G1" 9)}
wvSetCursor -win $_nWave1 49452.724077 -snap {("G1" 9)}
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetCursor -win $_nWave1 29944.991213 -snap {("G1" 10)}
wvSetCursor -win $_nWave1 40382.249561 -snap {("G1" 8)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSetCursor -win $_nWave1 24726.362039 -snap {("G1" 2)}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSetCursor -win $_nWave1 19880.492091 -snap {("G1" 5)}
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSetCursor -win $_nWave1 39636.731107 -snap {("G1" 8)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 9325.846702
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 20128.998243 -snap {("G1" 5)}
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvSetCursor -win $_nWave1 29696.485062 -snap {("G1" 10)}
wvSetCursor -win $_nWave1 39388.224956 -snap {("G1" 10)}
wvSetCursor -win $_nWave1 50198.242531 -snap {("G1" 10)}
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSetCursor -win $_nWave1 19880.492091 -snap {("G1" 6)}
wvSetCursor -win $_nWave1 30069.244288 -snap {("G1" 6)}
wvSetCursor -win $_nWave1 40382.249561 -snap {("G1" 6)}
wvSetCursor -win $_nWave1 49328.471002 -snap {("G1" 6)}
wvSetCursor -win $_nWave1 20128.998243 -snap {("G1" 6)}
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetCursor -win $_nWave1 40009.490334 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 20128.998243 -snap {("G1" 6)}
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvSetCursor -win $_nWave1 50322.495606 -snap {("G1" 6)}
wvSetCursor -win $_nWave1 20253.251318 -snap {("G1" 6)}
wvSetCursor -win $_nWave1 24974.868190 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 35163.620387 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 24850.615114 -snap {("G1" 2)}
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSetCursor -win $_nWave1 86480.140598 -snap {("G2" 0)}
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 65729.876977 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 74551.845343 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 115555.360281 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 125495.606327 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 115306.854130 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 109963.971880 -snap {("G1" 9)}
wvSetCursor -win $_nWave1 115431.107206 -snap {("G1" 2)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 110088.224956 -snap {("G1" 10)}
wvSetCursor -win $_nWave1 120028.471002 -snap {("G1" 5)}
wvSetCursor -win $_nWave1 110585.237258 -snap {("G1" 10)}
wvExit
