function [c, w] = fouriorseries(x, Tmin, Tmax, N)
% T = 2 * pi / w
% w = 2 * pi / T
syms t;
T = Tmax - Tmin;
w = zeros(1, N);
for k = 1:N
    c(k) = int(x*exp(-1i * 2 * pi * (k-1) * t / T), t, Tmin, Tmax) / T; 
    w(k) = 2 * pi * (k-1) / T;
end

end
