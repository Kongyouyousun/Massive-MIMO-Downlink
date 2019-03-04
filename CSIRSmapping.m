function [grid,CSIRSIndices]=CSIRSmapping(grid,CSIRS,gnb,port)
wf = [1 1;...
    1 -1;...
    1 1;...
    1 -1;...
    1 1;...
    1 -1;...
    1 1;...
    1 -1];
wt = [1 1 1 1;...
    1 1 1 1;...
    1 -1 1 -1;...
    1 -1 1 -1;...
    1 1 -1 -1;...
    1 1 -1 -1;...
    1 -1 -1 1;...
    1 -1 -1 1];
index = ceil(port/4);
idx1 = [4 6 8 10];
% idx1 = [1 2 3 4];
idx2 = [1 2];
CSIRSIndices = [];
numRB = gnb.NDLRB;
for RB=1:numRB
    for k=1:2
        a1 = (RB-1)*12+idx1(mod(port-1,4)+1)+k-1;
%         a1 = (RB-1)*12+idx1(mod(port-1,4)+1)+(k-1)*6;
        for l=1:4
            a2 = 7+l;
%             grid(a1,a2)=wf(index,idx2(k))*wt(index,l)*CSIRS((RB-1)*8+(l+(k-1)*4));
            grid(a1,a2)=CSIRS((RB-1)*8+(l+(k-1)*4));
        end
        CSIRSIndices = [CSIRSIndices;a1+numRB*12*7];
    end
end
CSIRSIndices = [CSIRSIndices;CSIRSIndices+numRB*12;CSIRSIndices+numRB*24;CSIRSIndices+numRB*36];
    
    
    