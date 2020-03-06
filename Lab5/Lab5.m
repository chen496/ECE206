% From now on, we move to frequency domain analysis on continuous-time
% system. As you have learned in ECE307, we can use the Laplace transform
% depending on a complex variable s = x + jy, where x is the damping
% coefficient and y is the frequency. This definition is from the eular
% formula of complex variable, exp(x + jy) = exp(x) exp(jy) =
% exp(x)(cos(y) + j sin(y)). They are used to characterize the
% continuous-time signal.
% For example, we can use Matlab's symbolic toolbox to analysis the Laplace
% transformation and its zero/pole and ROC(region of convergence)
% Let us consider the unit step function on its frequency domain
%syms t s u;
% unit-step function
%u = heaviside(t);
%figure(1);
%fplot(u, [-5, 5]); ylim([-0.5, 1.5]); 
%grid; title('unit-step');
% laplace transform
%U = laplace(u);
% For delta function
%syms d;
%d = dirac(t);
%figure(2);
%fplot(d, [-5, 5]); ylim([-0.5, 1.5]);
%grid; title('delta');
%D = laplace(d);
% laplace in matlab is one-side laplace, integral from 0 -> Infty.
syms t s p;
p = heaviside(t+1) - heaviside(t-1);
P = laplace(p, t, s);
figure(5);
fplot(p, [-5, 5]); ylim([-2, 2]);
grid; title('$$u(t+1) - u(t-1)$$','interpreter', 'latex');
% This is one side laplace transform, in matlab since we always consider
% the signal (which start from 0), so the default laplace transform always
% start from 0. U can also consider it as a original signal multiplied by
% u(t). For two-sided laplace transform, in next class, we will discuss it can be decomposed into
% multiple one-sided laplace trasform in different region of convergence
% (ROC)
% to calulate zero and pole
% obviously s = 0 is pole but it is cancelled by zero @ 0.
pzero = solve(P == 0);
% Notice, in Matlab Symbolic, all laplace transform is one-side laplace.
% which means that original signal in time domain always can be treated as
% x(t) u(t).
% And in next example, let us try to plot out laplace transformation's
% zero and polar.
% Let us consider, 
% 1, x(t) = exp(-t)u(t)
% 2, y(t) = exp(-t)cos(10t)u(t)
% First, let us compute the laplace transformation by hand.
% Second, we also can get laplace by symbolic toolbox.
syms x y t;
xs = exp(-t) * heaviside(t);
xd = exp(-t);
Xs = laplace(xs);   % Xs denotes one-side and Xd denotes teo-sides laplace
Xd = laplace(xd);   
% Comparing Xs and Xd, we have that laplace in matlab is one-side laplace
% and it is equivalent to right multiplied by unit-step signal function as
% filter.
y = exp(-t) * cos(10 * t);
Y = laplace(y);
% plot signal and ploe/zero
figure(3)
subplot(221)
fplot(xs, [0, 5]); grid(); title('$$x = e^{-t}u(t)$$', 'interpreter', 'latex')
subplot(222);
% 1/(s+1) has only one pole, represented as 'x' in plot
zplane([0 1], [1 1]); grid(); 
subplot(223);
fplot(y, [0, 5]); grid(); title('$$y = cos(10t)e^{-t}u(t)$$', 'interpreter', 'latex')
subplot(224);
zplane([0 1 1], [1 2 101]); grid();
% Equivalent operation
% [z, p] = tf2zp([0 1 1], [1 2 101]);
% figure(6);
% zplane(z, p); grid;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Next, let us discuss the relationship between pole and ROC(region of convergence)
% For ROC's definition, we have it is about the constraint on real part, so
% that
% |\int_{C} x(t) e^{-st} dt| \leq \infty.
% s = x + jy
% \int_{C} |x(t)| e^{-xt} dt < \infty
% From this definition, we have
% 1. Since F(s) < \int_{C} |x(t)| e^{-xt} dt, so pole of F(s) should not be
% present in the ROC
% 2. ROC only consider the real-part of s, so ROC is plane parellel to the
% j axis.
% For example.
% h(t) = e^{-t}u(t) + e^{2t}u(t)
% As we discussed in last week, the integral is an operator follows
% linearity. So we have
% L(h) = L(e^{-t}u(t)) + L(e^{2t}u(-t))
% int_0^{\infty} e^{-t}e^{-st}dt = 1 / (1 + s)  --> pole -1
% -int_0^{\infty} e^{-2t}e^{st}dt = 1 / (2 - s)  --> pole 2
syms h u t;
syms x y;
u = heaviside(t);
x = exp(-t) * u;
X = laplace(x);
% notice that laplce in matlab are only one-siede (0->infty), So the y fed
% into matlab will be changed
y = exp(2*t) * u;
Y = -laplace(y);
H = X + Y;
% H = -3/(s+1)(s-2)
figure(4);
subplot(211);
fplot(x + y, [0, 5]); grid(); title('$$e^{-t}u(t) + e^{2t}u(t)$$', 'interpreter', 'latex');
subplot(212)
[vz, vp, vk] = zplane([0 0 -3], [1 -1 -2]); axis([-3 4 -1 1]); grid(); hold on;
% For ROC, so far, the methods to determine it is manully, then we calculate the ROC
% 0 < int_0^{\infty} |e^{-t}||e^{-xt}|dt < \infty
% 0 < 1 / (1 + x) < \infty --> x > -1
% 0 < int_0^{\infty} |e^{2t}||e^{-xt}|dt < \infty
% 0 < 1 / (2 - x) < \infty --> x < 2
% ROC == -1 < x < 2
% But we can find that the ROC always can be determined by poles
h = fill([vp.XData(2) vp.XData(2), vp.XData(1) vp.XData(1)], [min(ylim) max(ylim) max(ylim) min(ylim)], 'blue');
% set edgealpha = 0 for remove boundary on ROC
set(h, 'edgealpha', 1, 'facealpha', 0.5);

% Assignment 4. Do analysis on signal function
% h(t) = u(t) - u(t-1)
% You need use matlab anaylis it on frequency domain
% H(s)
% zero and pole?
% ROC
% plot them out.
syms t h;
h = heaviside(t) - heaviside(t-1);
H = laplace(h);
z = solve(H == 0);
p = solve(1/H == 0);
figure(4)
z = [linspace(-5, -1, 5) linspace(1, 5, 5)]  .* z;
zplane(z', p);
axis([-11 11 -20 20]);
xline(-10, 'Color','black','LineStyle','--');
plot([-10 -10], [min(ylim) max(ylim)], 'Color','black','LineStyle','--');
xline(10, 'Color','black','LineStyle','--');
grid;
hold on;
% Whole space is ROC, no poles.
h = fill([-10 -10 10 10], [min(ylim) max(ylim) max(ylim) min(ylim)], 'blue');
% set edgealpha = 0 for remove boundary on ROC
set(h, 'edgealpha', 0, 'facealpha', 0.1);
