%pitchTrackHPS- takes in an aribitrary audio signal and generates an
%estimated pitch track based on frames of the signal..
%INPUTS: 
% x- the speech signal in question
%fs -sampling rate
%frame_length- length of frame you will look at for signals. (Transformed
%to block size based on sampling rate)
%frame_overlap - how much overlap between frame samples. (Transformed to
%blockOverlap based on sampling rate)
% show toggles plotting features

%OUTPUTS:
%pitchTrack- contains frequency estimations within each corresponding frame
%of the signal
%trackIndex- the time index of each pitchTrack frame


%CALLS:
%PitchSpectralHps- computes pitch based off of harmonic product spectrum

function [pitchTrack, T] = pitchTrackHPS(x, fs, frame_length, frame_overlap, window, show)
 %First initialize the length basic variables such as the
 %blocks(Size/Overlap)
 N = length(x);
 blockSize = round(frame_length  * fs / 1000); % convert ms to points
 blockOverlap = round(frame_overlap * fs / 1000); % convert ms to points
 

 
%frame processing
 position = 1; i = 1;
 while (position+blockSize < N)
     frame = x(position:position+blockSize-1);
     pitchTrack(i) = PitchSpectralHps(frame, fs);
     position = position + (blockSize - blockOverlap);
     i = i + 1;
 end
 T = (round(blockSize/2):(blockSize-blockOverlap):N-1-round(blockSize/2))/fs;
 
if show 
    % plot waveform
    subplot(2,1,1);
    t = (0:N-1)/fs;
    plot(t, x);
    legend('Waveform');
    xlabel('Time (s)');
    ylabel('Amplitude');
    xlim([t(1) t(end)]);

    % plot  pitchTrack
    subplot(2,1,2);
    plot(T,pitchTrack);
    legend('pitch track via HPS');
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    xlim([t(1) t(end)]);
end