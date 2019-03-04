# Massive-MIMO-Downlink
Detection and Precoding

main function: My5g_Test_rewrite_chan4_to_8_similar_Uplink

Problems:
[rxdata,~,decState] = h5gDLSCHDecode(gnb_origin,pdsch_origin,trBlk,codedTrBlockall(:,port,BW),decState);
这个函数的对称形式没有找到？

第一个子带均衡后是对的，第二个子带均衡后就错了。为什么？


















