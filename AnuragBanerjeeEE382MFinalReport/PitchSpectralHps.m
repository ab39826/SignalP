function [freqGuess] = PitchSpectralHps(x, fs)
 
% initialize
order  = 4;
minFreq   = 300;
 
harmonicPS   = x;
minK   = round(minFreq/fs * 2 * size(x,1));

if minK ==0
    minK =1;
end
 
% compute the HPS
for (j = 2:order)
harmonicPS   = harmonicPS .* [x(1:j:end,:); zeros(size(x,1)-size(x(1:j:end,:),1), size(x,2))];
end
 
% find max index and convert to Hz
%[fDummy,freqGuess]  = max(harmonicPS(minK:end,:),[],1);
%freqGuess           = (freqGuess + minK - 1) / size(x,1) * fs/2;

ms2range=floor(fs*0.002); % 2ms
 ms20range=floor(fs*0.02); % 20ms
 [maxIndex,maxTime]=max(abs(harmonicPS(ms2range:ms20range)));
 freqGuess = fs/(ms2range+maxTime-1);

end