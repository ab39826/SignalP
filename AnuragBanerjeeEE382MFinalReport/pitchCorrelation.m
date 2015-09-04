%pitchCorrelation computes the autocorrelation of the given frame.

%INPUTS: 
% x- the speech signal frame in question
%fs -sampling rate
%window- type of window you want to use

%OUTPUTS:
%r is a vector of correlation coefficients

function [r] = pitchCorrelation(x, fs, window)
 show = 0;
 maxlag = fs/50; %Based on experimentation
 if strcmp(window, 'rectwin')
     window = rectwin(length(x));
 end
  
 if strcmp(window, 'hamming')
    window = hamming(length(x));
 end
 
 %generate windowed version of frame
  x = x(:) .* window(:);

 %Actually do the autocorrelation
 r = xcorr(x, maxlag, 'coeff');
 
 if show
     %regular speech signal
     t=(0:length(x)-1)/fs;        % samp time instants
     subplot(2,1,1);
     plot(t,x);
     legend('Waveform');
     xlabel('Time (s)');
     ylabel('Amplitude');
     xlim([t(1) t(end)]);

     %autocorrelation
     d=(-maxlag:maxlag)/fs;
     subplot(2,1,2);
     plot(d,r);
     legend('Auto-correlation');
     xlabel('Lag (s)');
     ylabel('Correlation coef');
 end
end