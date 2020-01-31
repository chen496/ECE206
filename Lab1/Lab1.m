% Lab 2: Signal generation
% How can we generate a discrete sigle using matlab
% For example if we have the signal's explicit formula
% we can generate its numeric approximation. 
% And this example will show you that how we generate a
% signal y(t) with known support
% And y(t) = 3 ramp(t+3) - 6 ramp(t+1) + 3 ramp(t) - 3 unitstep(t-3)
% where ramp is continuous funciton = t u(t); its derivate is unit-step
% function
% while unistep function is a function with only 2 values in its domain. 
% unitstep function u(t) equals to zero when t < 0 and u(t) = 1 when t >= 0
% therefore, in this system, we know that it is clear aformed by a time-invariant
% part unit-step and a time variant part ramp
clear all; clf;
% To plot numeric appromation, we need define the minimal step of each
% discrete point.
Ts = 0.1;
% Then, we plot the signal from -5 to 5; the support of it can be define as
% t
t = -5:Ts:5;
% Then, let us define the ramp signal function tu(t) and unit-step function
% in ustep.m and ramp.m. The we can write out the signal y as
y = ramp(t, 3, 3) + ramp(t, -6, 1) + ramp(t, 3, 0) - 3 * ustep(t, -3);
% result plot
figure(1)
plot(t, y, 'k');
%stem(t, y);
axis([-5 5 -1 7]);
grid;
title('$$y(t)=3r(t+3)-6r(t+1)+3r(t)-3u(t-3)$$', 'interpreter', 'latex');
% Assignment 1.1
% plot this function, and please analysis each part of function y(t)
% For example, y(t) = 0 for t < -3 and t > 3, this imply us we selected
% t in [-5, 5] is proper.
% And then, please also write down the segment :
% -3 <= t <= -1
% -1 < t <= 0
% 0 < t <= 3

% section 2. When u study ECE 206/307. You will always use a very useful
% analysis on response signal summetry property.
% They are Even / Odd Signal of it.
% If a signal x(t) conincides with its reflection x(-t). we have
% x(t) = x(-t). This signal is symmetric with respect to time original 0
% While if a signal x(t) is conindides with is negative reflection -x(-t).
% This means the signal is nonsymmtric w.r.t time origin, we call it odd
% signal. So we always can decompose an arbitrary signal into even and odd
% parts. y(t) = y_e(t) + y_o(t). Then we can easily build them as
% y_e(t) = 1/2(y(t) + y(-t)); y_o(t) = 1/2(y(t) - y(-t))
% So, let us try to use these two definition to anlaysis the above example.
% and then, get the odd & even part of y(t)
[yo, ye] = oddeven(t, y);
figure(2)
subplot(211);
plot(t, yo, 'r');
title('odd part signal of y(t)')
grid
axis([min(t) max(t) -4 4])
subplot(212);
plot(t, ye, 'k')
title('even part signal of y(t)')
grid
axis([min(t) max(t) -2 7])

% Assignment 1.2 
% If we have a new signal
% y(t) = 2 * ramp(t + 2.5) - 5 * ramp(t) + 3 * ramp(t - 2) + ustep(t-4)
% Please plot y(t), and extract its even & odd parts out. 

