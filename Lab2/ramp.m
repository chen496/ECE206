% For the time-variant ramp signal let us use the same strategy to
% define it on given time supports t
function y = ramp(t, m, ad)
% t is our given time support
% m is the scale of ramp signal
% ad is the shift of ramp signal on time same definition as unit-step
N = length(t);
y = zeros(1, N);
for i = 1:N
   if t(i) >= -ad
       y(i) = m * (t(i) + ad);
   end
end
end