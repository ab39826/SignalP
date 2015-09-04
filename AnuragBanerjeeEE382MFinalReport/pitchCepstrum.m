%pitchEstimate gives an estimate for pitch within the single frame based on
%cepstral method

%INPUTS:
%cepstrum- contains a frame of the cepstrum coefficients
%fs- sampling rate

%OUTPUTS:
%freqGuess- the estimate of the frequency

function [freqGuess] = pitchCepstrum(c, fs)
 % find peak between 2ms (=500Hz) and 20ms (=50Hz)
 ms2range=floor(fs*0.002); % 2ms
 ms20range=floor(fs*0.02); % 20ms
 [maxIndex,maxTime]=max(abs(c(ms2range:ms20range)));
 freqGuess = fs/(ms2range+maxTime-1);
end