%pitchEstimate gives an estimate for pitch within the single frame

%INPUTS:
%autoframe- contains a frame of the autocorrelation coefficients
%fs- sampling rate

%OUTPUTS:
%freqGuess- the estimate of the frequency

function [freqGuess] = pitchEstimate(autoframe, fs)

 %find peak within 2ms-20ms range
 ms2Range=floor(fs/500); % 2ms
 ms20Range=floor(fs/50); % 20ms
 
 % Only need 1/2 of autoframe because of symmetry.
 % This saves computational time
 autoframe = autoframe(floor(length(autoframe)/2):end);
 
 [maxIndex,maxTime]=max(autoframe(ms2Range:ms20Range));
 
 %based on time of peak, we can guess the frequency
 freqGuess = fs/(ms2Range+maxTime-1);
end