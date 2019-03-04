%   % Generate and decode 2 transmissions (RV=0 then RV=1) as part of a 
%   % single 5G DL-SCH codeword HARQ process.
%
  enb = struct();
  chs.Modulation = 'QPSK';
  chs.NLayers = 1;
  chs.TargetCodeRate = 0.5;
  trBlkSize = 28336;
  codedTrBlkSize = 38880;

  trBlkData = randi([0,1],trBlkSize,1);
  chs.RV = 0; % Create a codeword with RV = 0
  cw = h5gDLSCH(enb,chs,codedTrBlkSize,trBlkData);
  cw(cw == 0) = -1;        % Turn logical bits into 'LLR' data
  % Initialize the decoder states for the first HARQ transmission 
  decState = [];
  [rxTrBlk,~,decState] = h5gDLSCHDecode(enb,chs,trBlkSize,cw,decState);
  err_port=length(find(rxTrBlk~=trBlkData))
  
  
  
  % Returned decState contains the decoder buffer state for each 
  % transport block for an active HARQ process
  % Create a second retransmitted codeword with RV = 1
  chs.RV = 1;        
  cw = h5gDLSCH(enb,chs,codedTrBlkSize,trBlkData);
  cw(cw == 0) = -1;  % Turn logical bits into 'LLR' data
  % Previous transmission decoder buffer state, decState, is used
  % as part of the sequence of active HARQ transmissions
  rxTrBlk = h5gDLSCHDecode(enb,chs,trBlkSize,cw,decState);
  err_port=length(find(rxTrBlk~=trBlkData))
  
  
  
  
  
  
  
  
  
  
  