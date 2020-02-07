function y = ustep(t, shift)
% t is the time
% ad is the shift of singal. If ad is positive, it means that basic
% unitstep function have a advance effect. And if ad < 0, it means that
% basic unitstep have a delay effect
% then, we can plot uit-step function's response on support of given time
N = length(t);   % how many discrete points we will have
y = zeros(1, N);
for i = 1:N
   if t(i) >= -shift
       y(i) = 1;
   end
end

end