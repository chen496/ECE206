% In last our lab2 and lab3, we have learned how to generate signal of
% several simple LTI(linearity time invariant) or non-LTI signal.
% So, today, let us go into the detail of the LTI continuous time System,
% and use Matlab as a tool to learn the properties of any given Continuous
% time systems, to determine whether they are LTI or not.
% First, a continuous-time system is a system whose input x(t) and output
% y(t) are continuous-time signals. Let us use S to denote the
% transformation function between x(t) and y(t), then, we have
% y(t)          = S(x(t)). 
% [response]      [signal]
% Then, based on the Mathmatic representation of a continuous-time system,
% we can consider several characteristics of it.
% 1. Linearity,
% Linearity of a system is corresponding to the map between our systems'
% output and input. If the map between them are linearty, which means that
% two conditions satisfied, they are additivity and scalar multiplication.
% For example in a response-input map, we have y(t) = S(x(t)), where S
% denotes the mapping. Then, let us check, if
% ay(t) = S(ax(t));(scalar multiplication) and
% if y(t) = S(x(t)), v(t) = S(u(t)); Then y(t) + v(t) == S(x(t) + u(t));
% (additivity property).
% These two criteria make sure that our system is linear.
% For example, Let us consider a bias-averager system:
% y(t) = 1/T int_{t-T}^t x(\tau)d\tau + const
% We check these properties for its linearity;
% 1. Scaling: x(\tau) --> ax(\tau), then we have new signal is
% u(t) = 1/T int_{t-T}^t ax(\tau)d\tau + const
% = a/T int_{t-T}^t ax(\tau)d\tau + const != ay(t)
% since ay(t) = a/T int_{t-T}^t ax(\tau)d\tau + a const
% Similar, 2. Additivity: 
% y(t) = 1/T int_{t-T}^t x(\tau)d\tau + const
% v(t) = 1/T int_{t-T}^t u(\tau)d\tau + const
% c(t) = 1/T int_{t-T}^t [x(\tau) + u(\tau)] d\tau + const != 
% y(t) + v(t). Unless const == 0;
% Therefore, we can use similar strategy to check whether our system is
% linear mapping or not.
% Once we determined whether the continuous-time system is linear or not.
% For LTI system, we need to check whether it is time-invariant or not.
% Time invariance is a property which implies that the relationship between
% input signal x(t) and their response y(t) is independent with t.
% For example, if our system is y(t) = 10x(t); then, y(t+dt) = 10x(t+dt).
% If u want to check whether ur system is time-invariant or not.
% Please always write ur y(t) = S(x(t)) as f(t)x(t). If the f(t) is a
% constant term, y(t) is TI, otherwise y(t) is TV(time varing).
% For example, let us consider the AM(amplitude modulation) system,
% y(t) = cos(\Omega t)x(t). Obviously, cos(\Omega t) depends on `t`. So
% our AM system is time varying. Additionally, we also can prove that AM is
% a linear system(Proof?)
% Therefore, if we wish to build a general system framework which is always
% LTI system, let us consider the convolution integral:
% y(t) = int_{-\infty}^{\infty} x(\tau)h(t - \tau)d\tau
% For this system. its LTI property can be easily proved.
% y_1(t) = int_{-\infty}^{\infty} x_1(\tau)h(t - \tau)d\tau
% y_2(t) = int_{-\infty}^{\infty} x_2(\tau)h(t - \tau)d\tau
% ay_1(t) = a int_{-\infty}^{\infty} x_1(\tau)h(t - \tau)d\tau = 
% int_{-\infty}^{\infty} ax_1(\tau)h(t - \tau)d\tau
% y_1(t) + y_2(t) = int_{-\infty}^{\infty} [x_1(\tau) + x_2(\tau)]h(t - \tau)d\tau
% For example, let us consider a Zener diode in Matlab
% input v(t) = cos(pi * t);
% output y(t) is a clipped sinusoid;
% y(t) = 0.5 if |v(t)| > 0.5
% y(t) = v(t) otherwise
% Obviously, 
% y_1(t) = S(v_1(t));
% y_2(t) = S(v_2(t));
% We have contradiction that 
% if |v_*| <= 0.5 and |v_1 + v_2| > 0.5, we have y_1(t1) + y_2(t2) = cos(pi t1) + cos(pi t2)
% however y(v1(t)+v2(t)) = 0.5
% In addition, we have y(t) is cyclic, so it is TI
clear all; clf;
Ts = 0.001;
t = -4:Ts:4;
% create zener.m
x = cos(pi * t);
y = zener(x);
figure(1)
subplot(211);
plot(t, y, 'k');
axis([-4 4 -1 1]);
grid;
title('zener@x(t) = cos(pi * t)');
% If we change our input to 0.3 * x(t)
x = 0.3 * cos(pi * t);
y = zener(x);
subplot(212);
plot(t, y, 'k');
axis([-4 4 -1 1]);
grid;
title('zener@x(t) = 0.3 * cos(pi * t)');
% Obviously, scalar multiplication is failed on zener diode. Therefore, we
% claim that this system is non-linear.
% However, we can claim that our system is time invariant.
x = cos(pi * t);
y = zener(x);
% shit y on t
d = 1;
tnew = t - 1;
% shit on input
xnew = cos(pi * (t+d));
ynew = zener(xnew);
figure(2)
subplot(211);
plot(tnew, y, 'k');
axis([-3 3 -1 1]);
grid;
title('y(t+1)');
subplot(212);
plot(t, ynew, 'k');
axis([-3 3 -1 1]);
grid;
title('zener(x(t+1))');

% Another example is the FM signal generator, which is different from the
% AM we dicussed earlier today. FM use the input signal to modify the
% frequency of cos(\Omega t), compared with AM, it multiplies m(t) on
% cos(\Omega t). Where \Omega is a carrier frequency. For example, we set
% it to 2 * pi. Then, we have a continuous-time system
% y(t) = cos(2 * pi * t + 2 * pi * v * int_0^t m(\tau) d\tau
% To simulate this signal in Matlab by numeric approximation.
% First, let us create a integal function by definition of integral
% we have int_a^b f(x) = sum f(x(t)) * (a-b)/N
% m = @(t) cos(t);
% y = integral(m, 0, pi / 2, 1e-4);
% Then, we can create a signal y(t) from FM by defining FM.m
Ts = 0.01;
t = 0:Ts:10;
x = @(t) cos(t);
y = fm(x, t);
figure(3)
subplot(211);
plot(t, y, 'k');
axis([0 10 -1 1]);
grid;
title('FM @ v=1');
subplot(212);
x2 = @(t) 10 * cos(t);
y2 = fm(x2, t);
plot(t, y2, 'k');
axis([0 10 -1 1]);
grid;
title('FM @ v=10')


% FM in symbolic toolbox
syms t u
y = cos(2 * pi * t + 2 * pi * 10 * int(cos(u), u, 0, t));
fplot(y, [0, 10]);

fms = @(v) cos(2 * pi * t + 2 * pi * v * int(cos(u), u, 0, t));
fplot(fms(10), [0, 10]);

m = heaviside(u) - heaviside(-u);
fplot(m, [-5, 5])
fmc = @(v) cos(2 * pi * t + 2 * pi * v * int(m, u, 0, t));
