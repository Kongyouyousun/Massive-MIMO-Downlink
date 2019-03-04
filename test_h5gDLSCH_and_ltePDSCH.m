       







%             clc,clear,close all

%             trdata = randi([0,1],trBlk,1);
% %             trdataAll(:,layer,BW)=trdata;
%             codedTrBlock = h5gDLSCH(gnb, pdsch, codedTrBlkSize*4, trdata);
%             % LTE PDSCH complex symbol generation
%                
%                  pdschSym = ltePDSCH(gnb, pdsch, codedTrBlock);
% %             发送的符号，均衡后的符号
% %             pdschTx_all;%发送的符号
% %             pdschRxEq_all(:,:,BW)=pdschRxEq;%5280x32
% %             pdschTx=pdschTx_all(:,:,BW);
% %             isequal(pdschRxEq,pdschTx)
% %               for port=1:32
%                   [rxCws,symbols] = ltePDSCHDecode_modify(gnb, pdsch, pdschSym);%8360x1
%                   codedTrBlock_Eq=rxCws{1,1};
%                   codedTrBlock_Eq(codedTrBlock_Eq<0)=0;
%                   codedTrBlock_Eq(codedTrBlock_Eq>0)=1;
%                   
%                   isequal(codedTrBlock,codedTrBlock_Eq)
%                   
%                   codedTrBlock_Eq(codedTrBlock_Eq == 0) = -1;
                  
                  
                  trBlk=22152;
                  trdata = randi([0,1],trBlk,1);
                  codedTrBlkSize=38880;
                  codedTrBlock = h5gDLSCH(gnb, pdsch, codedTrBlkSize*4, trdata);
                  codedTrBlock(codedTrBlock == 0) = -1; 
                  decState = [];
                  [rxdata,~,decState] = h5gDLSCHDecode(gnb,pdsch,trBlk,codedTrBlock,decState);%仅仅是一个子带的接收判决后的数据.
%                   txdata=trdataAll(:,port,BW);%拿出所有的子带的发送数据.
                  err_port=length(find(rxdata~=trdata));
%                   rxdataAll(:,port,BW)=rxdata;
                  fprintf('error bits in port 的个数为: %d\n',err_port);
%                   err_allusers=err_allusers+err_port;%一个子带上的所有用户的错误估计比特.
                  
%                   figure
%                   plot(pdschRxEq(:,port), 'o', 'MarkerEdgeColor', [0 0 0.75], ...
%                       'MarkerFaceColor', [1 0.25 0.25], 'MarkerSize',3);title('均衡后','FontSize',8);
%                   axis([-1,1,-1,1].*2);
          
%               end
%               err_allbws=err_allbws+err_allusers;