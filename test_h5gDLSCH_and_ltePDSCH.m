       







%             clc,clear,close all

%             trdata = randi([0,1],trBlk,1);
% %             trdataAll(:,layer,BW)=trdata;
%             codedTrBlock = h5gDLSCH(gnb, pdsch, codedTrBlkSize*4, trdata);
%             % LTE PDSCH complex symbol generation
%                
%                  pdschSym = ltePDSCH(gnb, pdsch, codedTrBlock);
% %             ���͵ķ��ţ������ķ���
% %             pdschTx_all;%���͵ķ���
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
                  [rxdata,~,decState] = h5gDLSCHDecode(gnb,pdsch,trBlk,codedTrBlock,decState);%������һ���Ӵ��Ľ����о��������.
%                   txdata=trdataAll(:,port,BW);%�ó����е��Ӵ��ķ�������.
                  err_port=length(find(rxdata~=trdata));
%                   rxdataAll(:,port,BW)=rxdata;
                  fprintf('error bits in port �ĸ���Ϊ: %d\n',err_port);
%                   err_allusers=err_allusers+err_port;%һ���Ӵ��ϵ������û��Ĵ�����Ʊ���.
                  
%                   figure
%                   plot(pdschRxEq(:,port), 'o', 'MarkerEdgeColor', [0 0 0.75], ...
%                       'MarkerFaceColor', [1 0.25 0.25], 'MarkerSize',3);title('�����','FontSize',8);
%                   axis([-1,1,-1,1].*2);
          
%               end
%               err_allbws=err_allbws+err_allusers;