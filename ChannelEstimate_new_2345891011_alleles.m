function PMI = ChannelEstimate_new_2345891011_alleles(grid,txgrid,CSIRSIndices)
numport = size(grid,3);
nSC = size(grid,1);
% PMI = complex(zeros([size(grid) numport]));
%uplink SRS 信道估计
PMI = complex(zeros([size(grid),numport]));%1320x12x32x32
for numRx = 1:numport
    rxGrid = grid(:,:,numRx);
    for numTx =1:numport
        port = numTx;
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
        txGrid = txgrid(:,:,numTx);
        first = mod(numTx,4);
        if first==0
            first = 4;
        end
        indices = (first:4:nSC)+(symbol-1)*nSC;
        srsTx = lteExtractResources(indices,txGrid);
        srsRx = lteExtractResources(indices,rxGrid);
        hp = srsRx./srsTx;
        P_EST = complex(zeros(size(grid,1),1));
        
        %%获取每个天线对应的资源网格的SRS的位置
        indices = (first:4:nSC);
        P_EST(indices) = hp;
        y =  interp1(find(P_EST~=0),P_EST(P_EST~=0),(1:length(P_EST)).','linear','extrap');
        hD = y(:,ones(1,12));  %12 for extended cp
        PMI(:,:,numRx,numTx)=1*hD;
    end
end