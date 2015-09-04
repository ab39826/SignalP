function voicedComponent = voiced(frame);

zcThresh = .05;
enThresh = .5;

%Vectorized computation of zcr/short-time energy for each block of speech
zcrVal = zcr(frame);
en = energy(frame);

%Indicator vector corresponding to speech samples that satsify threshold
%conditions
zcrThreshVec = zcrVal < zcThresh;
energyThreshVec = en > enThresh;

%Combination indicator vector corresponding to voiced sequences.
voicedComponent = zcrThreshVec*energyThreshVec;

end