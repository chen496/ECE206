% A new perspective of Laplace transform(On frequency analysis)
% This is also a pre-analysis for Fourior transform
% **1, Spectral representation. 
% As in Laplace transform, we always have F(s) = \int f(t)exp(-ts)dt,
% where, t = \sigma + j\omega. Therefore, the signal shows that it is
% always represented with several specific frequency. Such a signal
% distribution over frequency is called the spectrum of a signal.
% **2, It is important to understand the driving force behind the
% representation of signals. Likewise, Laplace transform can be seen as the
% representation of signals in terms of a general eigenfunctions. But
% today, let us discuss several more general cases thjat do not only use a
% general eigenfucntion (corresponding to one frequency) to represent a signal.
% 
% Fro example, let us extend our input signal. In last three lab sections
% we discussed, we only consider the real signal, such as x(t) =
% exp(-at)u(t). But several times, our input signal can be generalized to a
% complex cases. Based on eular-equation, we assume a input is exp(jwt).
% Then, we have, a general ouput y(t) of LTI system can be formulated as a
% convolution intergrals as follow,
% y(t) = \int h(\tau)x(t-\tau)d\tau = exp(jwt)\int h(\tau)exp(-jw\tau)d\tau
% Therefore, y(t) is shown corresponding to a time-dependent term exp(jwt)
% and a frequency response \int h(\tau)exp(-jw\tau)d\tau of the w.
% Therefore, it our original signal can be decomposed into multiple
% orthogonal signal on different frequency w_k, it's convolution output
% signal also can be written as
% \sum_{k} exp(jw_kt) H(jw_k). 
% Since we find that complex exponential of different frequency are
% orthogonal with each other, we have can call them as the eigenfunction of
% a LTI system. This provide us an efficient way to compute the
% convoulation integral with complex exponential input.
% Remark.
% From above, we can easily have that y(t)'s expression can works on any
% frequency w.
% Why we use y(t) = \int h(\tau)x(t-\tau)d\tau but not y(t) = \int x(\tau)
% h(t-\tau) d\tau here.
% if h(t) = sigma(t-\tau).
% int x(r)h(t-r)dr = int x(r) sigma (t - \tau - r) dr = x(t-\tau).
% int h(r)x(t-r)dr = int sigma (r - \tau) x(t - r) dr = x(t-\tau).
% Therefore, only need r + (t-r) = t, the convolution integral satisfy.
% in this case, if x(t) = exp(jwt), we then have
% y(t) = exp(jwt) \int sigma(r - \tau)exp(-jwr)dr = exp(jwt)exp(-jw\tau)
% H(jw) = exp(-jw\tau), where w can be any specific frequency. and |H(jw)|
% === 1. Therefore, we the exp(jwt) will always be kept under any
% frequency. We call it all-pass.
% Case 2, let us consider a more complicated case.
% dy/dt + y(t) = x(t). This is a ODE
% If our X is signal in real domain, in the laplace definition, we have sY + Y = X,
% then we can solve it. Y = X / (1+s).
% But when x(t) = exp(jwt). since it is located in complex domain, we can
% reprensent its eigenfuncion as follow,
% exp(jwt) = exp(jwt)H(jw) + jw exp(jwt)H(jw)
% so we have H(jw) = 1 / (1 + jw)
% |H(jw)| = 1 / sqrt(1+w^2)
% so we can have
% if x(t) = cos(0t) + cos(10000t), where w_1 = 0, w_2 = 10000. And we can
% represented them as a real-part of signal x(t) = exp(j0t) + 1/2(exp(j10000t) +
% exp(-j10000t))
% y(t) = exp(j0t) H(j0) + 1/2(exp(j10000t)/(1+j10000) +
% exp(-j10000t)/(1-j10000)) = 1 + 1/2 * j / 10000 * cos(10000t).
% we can easily find that |H(jw)| --> 0 will cause their corresponding
% part--> 0. This tell us, use the Eigenfunction analysis, we can easily
% prove that the system is low-pass(only low frequency allow) or high-pass
% or all-pass.
% In this example, obviously, only low-frequence allow. So we call it is a
% low-pass filter.

% Additionally, let us discuss the  fourior transform. For fourior
% transform, first let us consider this example

% Let us consider a cyclic signal. 
% x(t) = B + A cos(wt+a)
% y(t) = B + A cos(wt-pi/2)
% obviously, x is a cyclic signal, its period T = 2\pi/w.
% So we can use the complex-exponential rewrite x and y as follow
% x(t) = B + A/2[exp(j(wt+a)) + exp(-j(wt+a))]
% x(t) = B + A/2exp(ja) [exp(jwt)] + A/2exp(-ja) [exp(-jwt)]
% Therefore, we have the fourior series is
% B, Aexp(ja)/2, Aexp(-ja)/2
% Similarly, we have
% for y(t), the fourior series is
% B, Aexp(-jpi/2)/2 = -Aj/2, Aexp(jpi/2)/2 = Aj/2
% In y, the |Y_*| = 1, and angle Y_* = -\pi/2 and \pi/2

% This is because that we have each coefficient of fourior transform is
% derived from the real-part and imaginary-part of \int_{T} x(t)
% exp(j(k-1)wt)dt, where T = 2 * pi / w
% for example, we have y(t) = 1 + sin(100t).
syms t;
y = 1 + sin(100 * t);
figure(1)
fplot(y, [0, 0.3]); grid; xlabel('$$t(sec)$$', 'interpreter', 'latex');
ylabel('$$y(t)$$', 'interpreter', 'latex');

[c, w] = fouriorseries(y, 2 * pi / 100, 20);
figure(2)
stem(w, abs(c)); grid; xlabel('$$\Omega(rad/sec)$$', 'interpreter', 'latex');
ylabel('$$|Y_k|$$', 'interpreter', 'latex');


figure(3)
stem(w, angle(c)); grid; xlabel('$$\Omega(rad/sec)$$', 'interpreter', 'latex');
ylabel('$$\angle Y_k$$', 'interpreter', 'latex'); ylim([-pi, pi]);



% Can we efficiently solve it?
% consider the fouriour series of signal
% If period T0 = 1
% the period signal u(t) - u(t - T0/4) + u(t - 3 * T0/4)
syms t x x1 s;
x = abs(cos(pi * t));
T0 = 1;
m = heaviside(t) - heaviside(t - T0);
x1 = cos(pi * (t - 0.5)) * m;
figure(4)
subplot(211)
fplot(x, [-0.5, 0.5]);grid;
subplot(212)
fplot(x1, [0, 1]);grid;

X1 = laplace(x1);

N = 20;
w = zeros(1, N);
for k = 1:N
    s = 2 * pi * (k-1) * i; 
    c(k) = subs(X1);
    w(k) = (k-1) * 2 * pi;
end

figure(5)
subplot(211)
stem(w, abs(c)); grid; xlabel('$$\Omega(rad/sec)$$', 'interpreter', 'latex');
ylabel('$$|X_k|$$', 'interpreter', 'latex');


[c, w] = fouriorseries(x, T0, 20);
subplot(212)
stem(w, abs(c)); grid; xlabel('$$\Omega(rad/sec)$$', 'interpreter', 'latex');
ylabel('$$|X_k|$$', 'interpreter', 'latex');


% Assignment 4
% Please re-organize the second scheme, which apply
% laplace transform to compute the Fourier series
% into a function file as 'fouriorseries.m', you can 
% name it as 'fouriorBylaplace.m'.
% 
% Then, please use the two schemes to solve the frourior series of
% signal
% y(t) = 1 + cos(100t)
% and then, compare their computation time
% Hint: 
% to measure the elasped time of your code
% use
% tic
%   % The program section to time. 
% toc
%tic 
%    [c, w] = fouriorseries(x, T0, 20);
%toc 


% Solution for y(t) = abs(sin(2\pit))
syms t;
y = abs(sin(2 * pi * t));
% Method 1, directly by fouriorseries's integral
tic
[c, w] = fouriorseries(y, 0.5, 20);
toc
figure(6)
stem(w, abs(c)); grid; xlabel('$$\Omega(rad/sec)$$', 'interpreter', 'latex');
ylabel('$$|Y_k|$$', 'interpreter', 'latex');


% Method 2, Via laplace transform
syms t;
T0 = 0.5;
m = heaviside(0) - heaviside(t - T0);
y = cos(2 * pi * (t - 0.25)) * m;
Y = laplace(y);

tic
Y = laplace(y);
N = 20;
for k = 1:N
    s = 4 * pi * (k-1) * 1i; 
    c(k) = subs(Y);
    w(k) = 2 * pi * (k-1) / T0;
end
toc
figure(6)
stem(w, abs(c)); grid; xlabel('$$\Omega(rad/sec)$$', 'interpreter', 'latex');
ylabel('$$|Y_k|$$', 'interpreter', 'latex');


syms t s;
T0 = 1;
y = heaviside(t) - heaviside(t - 3/4);
Y = laplace(y);
N = 20;
for k = 1:N
    s = 2 * pi * k * 1i; 
    c(k) = subs(Y);
    w(k) = 2 * pi * (k-1) / T0;
end

