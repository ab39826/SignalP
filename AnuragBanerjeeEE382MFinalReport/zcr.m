function y = zcr(x)
%   zero crossing rate
%   Works for vector and matrix 

y = sum(abs(diff(x>0)))/length(x);

end
