%pitchTrackAuto- takes in an aribitrary audio signal and generates an
%estimated pitch track based on frames of the signal. This is a simple
%rectangular window that overlaps among signals, but it can be augmented to
%implement a hamming window to reduce smearing.

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
%autoFramed- matrix containing the autocorrelation function of each frame

%CALLS:
%pitchCorrelation- computes autocorrelation of a frame
%pitchEstimate - computes pitch based on autocorrelation

function [pitchTrack, T, autoFrame] = spPitchTrackCorr(x, fs, frame_length, frame_overlap, show)
 %First initialize the length basic variables such as the
 %blocks(Size/Overlap)
 N = length(x);
 blockSize = round(frame_length  * fs / 1000); % convert ms to points
 blockOverlap = round(frame_overlap * fs / 1000); % convert ms to points
 
%frame processing
 position = 1; i = 1;
 while (position+blockSize < N)
     frame = x(position:position+blockSize-1);
     frame = frame - mean(frame); % mean subtraction
     autoFrame(:,i) = pitchCorrelation(frame, fs, 'hamming');
     pitchTrack(i) = pitchEstimate(autoFrame(:,i), fs);
     VAD(i) = voiced(frame);
     
     %ZCRVec(i) = zcr(frame);
     %EnergyVec(i) = energy(frame);
     
     position = position + (blockSize - blockOverlap);
     i = i + 1;
 end
 T = (round(blockSize/2):(blockSize-blockOverlap):N-1-round(blockSize/2))/fs;

    pitchTrack = pitchTrack.*VAD;
 
if show 
    % plot waveform
    subplot(3,1,1);
    t = (0:N-1)/fs;
    plot(t, x);
    title('Audio of me Singing 4 Notes');
    xlabel('Time (s)');
    ylabel('Amplitude');
    xlim([t(1) t(end)]);

    % plot the pitch track
    subplot(2,1,2);
    plot(T,pitchTrack);
    title('Pitch Track via Autocorrelation');
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    xlim([t(1) t(end)]);

%     subplot(3,1,3);
%     plot(T,EnergyVec > .5);
%     title('ste');
%     xlabel('Time (s)');
%     ylabel('VoicedA)');
%     axis([t(1) t(end) 0 1.5])    
% 
%     subplot(3,1,2);
%     plot(T,ZCRVec < 0.05);
%     title('...................zcr');
%     xlabel('Time (s)');
%     ylabel('VoicedA');
%     axis([t(1) t(end) 0 1.5])
    
  
    
    
   
end