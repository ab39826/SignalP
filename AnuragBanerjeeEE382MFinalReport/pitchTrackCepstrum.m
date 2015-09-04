%pitchTrackCepstrum- takes in an aribitrary audio signal and generates an
%estimated pitch track based on frames of the signal. This uses a 
%hamming window that overlaps among signals to reduce smearing
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
%cepstrum- matrix containing the power cepstrum function of each frame

%CALLS:
%pitchCepstrum- computes cepstral coefficients of a frame
%pitchTrackCepstrum - computes pitch based on peak in power cepstrum

function [pitchTrack, T, cepstrum] = pitchTrackCepstrum(x, fs, frame_length, frame_overlap, window, show)
 %First initialize the length basic variables such as the
 %blocks(Size/Overlap)
 N = length(x);
 blockSize = round(frame_length  * fs / 1000); % convert ms to points
 blockOverlap = round(frame_overlap * fs / 1000); % convert ms to points
 

 
 %frame processing
 position = 1; i = 1;
 while (position+blockSize < N)
     frame = x(position:position+blockSize-1);
     cepstrum(:,i) = cepstrumCalc(frame, fs, window);
     pitchTrack(i) = pitchCepstrum(cepstrum(:,i), fs);
     VAD(i) = voiced(frame);
     position = position + (blockSize - blockOverlap);
     i = i + 1;
 end
 T = (round(blockSize/2):(blockSize-blockOverlap):N-1-round(blockSize/2))/fs;
 pitchTrack = pitchTrack.*VAD;
 
if show 
    % plot waveform
    subplot(2,1,1);
    t = (0:N-1)/fs;
    plot(t, x);
    title('C# 277 Hz Audio Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    xlim([t(1) t(end)]);

    % plot pitchTrack
    subplot(2,1,2);
    plot(T,pitchTrack);
    title('pitch track via cepstral methods');
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    xlim([t(1) t(end)]);
end