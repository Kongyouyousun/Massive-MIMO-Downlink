% function [grid,CSIRSIndices]=CSIRSmapping_new_2345891011(grid,CSIRS,gnb,port)
% % CSIRS插在OFDM的1，5，8，12（1-based）
% wf = [1 1;...
%     1 -1;...
%     1 1;...
%     1 -1;...
%     1 1;...
%     1 -1;...
%     1 1;...
%     1 -1];
% wt = [1 1 1 1;...
%     1 1 1 1;...
%     1 -1 1 -1;...
%     1 -1 1 -1;...
%     1 1 -1 -1;...
%     1 1 -1 -1;...
%     1 -1 -1 1;...
%     1 -1 -1 1];
% index = ceil(port/4);
% idx1 = [4 6 8 10];
% % idx1 = [1 2 3 4];
% idx2 = [1 2];
% CSIRSIndices = [];
% numRB = gnb.NDLRB;
% % idx3=[1 5 8 12];
% for RB=1:numRB
%     for k=1:2
%         a1 = (RB-1)*12+idx1(mod(port-1,4)+1)+k-1;
% %         a1 = (RB-1)*12+idx1(mod(port-1,4)+1)+(k-1)*6;
%         for l=1:4
%             a2 = idx3(l);
% %             grid(a1,a2)=wf(index,idx2(k))*wt(index,l)*CSIRS((RB-1)*8+(l+(k-1)*4));
%             grid(a1,a2)=wf(index,idx2(k))*wt(index,l)*CSIRS(RB);
% %             grid(a1,a2)=CSIRS((RB-1)*8+(l+(k-1)*4));
%         end
% %         CSIRSIndices = [CSIRSIndices;a1+numRB*12*7];
%          CSIRSIndices = [CSIRSIndices;a1];
%     end
% end
% CSIRSIndices = [CSIRSIndices;CSIRSIndices+numRB*12*4;CSIRSIndices+numRB*12*7;CSIRSIndices+numRB*12*11];

function [grid,CSIRSIndices]=CSIRSmapping_new_2345891011(grid,CSIRS,gnb,port)
% port是1-32的天线序号
% grid 时频资源网格
% 映射到时频资源网格中的ZC根序列
CSIRSIndices = [];
nSC = size(grid,1); %1320x12x32
numRB = size(CSIRS,1)/8*3;
index = mod(port,4);
if index==0
    index=4;
end
if (port>=1 && port<=4)
    symbol = 2;
elseif (port>=5 && port<=8)
    symbol = 3;
elseif (port>=9 && port<=12)
    symbol = 4;    
elseif (port>=13 && port<=16)
    symbol = 5;
elseif (port>=17 && port<=20)
    symbol = 8;
elseif (port>=21 && port<=24)
    symbol = 9;
elseif (port>=25 && port<=28)
    symbol = 10;
elseif (port>=29 && port<=32)
    symbol = 11;
end
% index = index + 12*7;
for RB=1:numRB
        a1 =(RB-1)*4+index;
        grid(a1,symbol)=CSIRS(RB);
        CSIRSIndices = [CSIRSIndices;a1+nSC*(symbol-1)];
end
























    
    