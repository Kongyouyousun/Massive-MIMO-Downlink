function y = MIMOFadingChan(in,prmMdl,port)
% MIMOFadingChan
%#codegen
% Get simulation params
numTx          = port;
numRx          = port;
chanSRate    = 122.88e6;   
PathDelays   = prmMdl.PathDelays ;
PathGains     = prmMdl.AvgPathGaindB;
Doppler         = prmMdl.MaxDopplerShift;

rho = 0.3;                                                        % Correlation coef. of transmit antennas
CM=[1 rho 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;rho 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
CM=[1 rho rho^2 rho^3 rho^4 rho^5 rho^6 rho^7 rho^8 rho^9 rho^10 rho^11 rho^12 rho^13 rho^14 rho^15 rho^16 rho^17 rho^18 rho^19 rho^20 ...
    rho^21 rho^22 rho^23 rho^24 rho^25 rho^26 rho^27 rho^28 rho^29 rho^30 rho^31];
SCMatrix=[CM;circshift(CM,1,2);circshift(CM,2,2);circshift(CM,3,2);circshift(CM,4,2);circshift(CM,5,2);circshift(CM,6,2);circshift(CM,7,2);circshift(CM,8,2);circshift(CM,9,2);...
          circshift(CM,10,2);circshift(CM,11,2);circshift(CM,12,2);circshift(CM,13,2);circshift(CM,14,2);circshift(CM,15,2);circshift(CM,16,2);...
          circshift(CM,17,2);circshift(CM,18,2);circshift(CM,19,2);circshift(CM,20,2);circshift(CM,21,2);circshift(CM,22,2);circshift(CM,23,2);...
          circshift(CM,24,2);circshift(CM,25,2);circshift(CM,26,2);circshift(CM,27,2);circshift(CM,28,2);circshift(CM,29,2);circshift(CM,30,2);circshift(CM,31,2)]; 
for i=1:32
    for j=1:(i-1)
        SCMatrix(i,j) = SCMatrix(j,i);
    end
end

% Initialize objects
chanObj = comm.MIMOChannel('SampleRate', chanSRate, ...
            'MaximumDopplerShift', Doppler, ...
            'PathDelays', PathDelays,...
            'AveragePathGains', PathGains,...
            'DopplerSpectrum',reshape(prmMdl.DopplerSpectrum,1,length(prmMdl.DopplerSpectrum)),...
           'TransmitCorrelationMatrix', eye(numTx),...
            'ReceiveCorrelationMatrix', eye(numRx),...
            'NormalizePathGains', true);      
y = step(chanObj, in);