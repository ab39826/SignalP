%Pitch Detection Algorithm
function [pitchVec] = pitchDetection(wav, method)
    [x, fs] = wavread(wav);
    
if strcmp(method, 'auto')
   [F0, T, R] = pitchTrackAuto(x, fs, 40, 25, 'plot');
end

if strcmp(method, 'cepstral')
    [F0, T, C] = pitchTrackCepstrum(x, fs, 40, 20, 'hamming', 'plot');
end

if strcmp(method, 'hps')
    [F0, T] = spPitchTrackHPS(x, fs, 25, 2, [], 'plot');
end

end