%cepstrum computes both the cepstrum and fourier response of the given frame.

%INPUTS: 
% x- the speech signal frame in question
%fs -sampling rate
%window- type of window you want to use

%OUTPUTS:
%c is a vector of cepstrum coefficients
%y is the fourier response

function [c, y] = cepstrumCalc(x, fs, window)
show = 0;
 N = length(x);
 x = x(:); % need column vec

 if strcmp(window, 'hamming')
    window = hamming(length(x));
 end
 
%First fourier
 x = x(:) .* window(:);
 y = fft(x, N);
 
 %get c from the log magnitude squared ifft. Converts to quefrency domain
 c = ifft(log(abs(y)+eps));
 
 if show == 1
     ms1Range=fs/1000; % 1ms. maximum speech Fx at 1000Hz
     ms20Range=fs/50;  % 20ms. minimum speech Fx at 50Hz
 
     t=(0:N-1)/fs;        % times of sampling instants
     subplot(2,1,1);
     plot(t,x);
     legend('Waveform');
     xlabel('Time (s)');
     ylabel('Amplitude');
 
     %q is quefrency
     q=(ms1Range:ms20Range)/fs;
     subplot(2,1,2);
     plot(q,abs(c(ms1Range:ms20Range)));
     legend('Cepstrum');
     xlabel('Quefrency (s) 1ms (1000Hz) to 20ms (50Hz)');
     ylabel('Amplitude');
 end
end