% In this section, we are going to discuss the matlab operations on
% inverse laplace. As we discussed how to transform continuous-time signal
% from its time-domain x(t) to frequency domain X(s), where s = x + jy.
% And from Cauchy theorem and Residual theorem, we also have 
% x(t) = 1/(2\pi j)\int_{x-j\infty}^{x+j\infty} X(s)exp(st)ds. 
% From laplace, we can easily have dirac(t)->1; u(t) -> 1/s; exp(-at)u(t)
% -> 1 / (s+a).
% All of these results also can be derived from matlab symbolic tools with
% function `laplace`. So, today, we will also try to compute
% inverse-laplace out by matlab.
% Before our code, let us firstly review several properties of ilaplace:
% 1. The pole of X(s) is related with the basis of x(t). From residual
% theorem. we always have 
% 1/(2\pi j)\int_{x-j\infty}^{x+j\infty} X(s)exp(st) = \sum_{a \in poles}
% Res(X(s)exp(st), a). Which means that each pole has corresponding
% residuals.
% 2. Since we always consider one-side laplace, so u(t) should be always
% included into result of integral.
% 
% From residual theorem, we have that residuals of X(s) are always coincide 
% with the order -1 term's coefficient in Laurent series, this part need you
% learn more about complex variable in future. But today, I will give you a
% conclusion as follow,
% Res(f, a) = \frac{1}{(n-1)!}\lim_{z \to a} \frac{d^{n-1}}{dz^{n-1}} [(z-a)^n f(z)]
% For example, for X(s) = 1/(s+a)
% Res(X(s)exp(st) , a) = \lim_{z \to -a} 1 exp(zt) = exp(-at)
% as the result, we modified with u(t) is ok. x(t) = exp(-at)u(t).
% Second for X(s) = 1/(s+a)^2
% Res(X(s)exp(st), a) = \lim_{z \to -a} \frac{d exp(zt)}{d z} = 
% \lim_{z \to -a} t exp(zt) = texp(-at)
% Finally, we have x(t) = texp(-at)u(t).
% From 1, we also have, if our X(s) can be decomposed into A_1/(s+a) +
% A_2/(s+b) for multiple poles, it is easily for us to write out residual
% for each part independently, and then sum them up. This is linearity of
% laplace transform.
%
% Example, for conjugate poles X(s) = 1/(s^2 + a^2) = 1/(2aj)(1/(s+aj) -
% 1/(s-aj))
% Res(X(s)exp(st), -aj) = lim_{z->-aj} 1/(aj) exp(st) = 1 / (2aj) exp(-jat)
% Res(X(s)exp(st), aj) = lim_{z->aj} 1/(aj) exp(st) = 1 / (2aj) exp(jat)
% Finally, we have x(t) = 1/a sin(at) u(t).
% Second, we have multiple-order X(s) as follow.
% X(s) = (a + b(s+a))/(s+a)^2 = a/(s+a)^2 + b/(s+a).
% Obviously, we have one pole s = -a, but it is 2-order.
% Res(X(s)exp(st), a) = lim_{z->-a}  \frac{d}{dz} [a + b(s+a)]exp(st) 
% x(t) = [atexp(-at) + bexp(-at)]u(t).
% And then, let us consider more complex case in matlab
% X(s) = (2s + 3) / (s^2 + 2s + 4) = (2s+3) / [(s+1)^2 + 3]
% X(s) = 1 / [(s+1)^2 + 3] + 1 / [s + 1 + j\sqrt(3)] + 1 / [s + 1 - j\sqrt(3)]
% Obviously, 2 poles (-1 - jsqrt(3)) and (-1 + j\sqrt(3))
% x(t) = exp(-t) (sin(sqrt(3) t) / t - cos(sqrt(3) t)) u(t)
% Thereofore, assignemnt :
% If we have X(s) = [a + b(s+a)]/[(s+a)^2 + O^2], can you write down the
% general x(t) for this formula? 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; clf;
syms s t w;
figure(1);
subplot(121);
zplane([0 2 3], [1 2 4]);  % write your X(s) into rational form N(s)/D(s) with coefficients of each term.
title('$$X(s) = (2s + 3) / (s^2 + 2s + 4)$$', 'interpreter', 'latex'); grid();
x = ilaplace((2*s + 3) / (s^2 + 2*s + 4));
subplot(122);
fplot(x, [0, 10]); title('x(t)'); grid(); axis([0 10 -0.5 2]);
% another way to calculate ilaplace
% by residual theorem. If we our poles have no imagenary part, we have
% pflaplace.m
% X(s) = [3s^2 + 2s - 5] / [s^3 + 6s^2 + 11s + 6]
x = pflaplace([0 3 2 -5], [1 6 11 6]);
figure(2);
subplot(121);
zplane([0 3 2 -5], [1 6 11 6]);  % write your X(s) into rational form N(s)/D(s) with coefficients of each term.
title('$$X(s) = [3s^2 + 2s - 5] / [s^3 + 6s^2 + 11s + 6]$$', 'interpreter', 'latex'); grid();
subplot(122);
fplot(x, [0, 10]); title('x(t)'); grid(); axis([0 10 -1 3]);
% Extra credits, optional.
% Obviously, we observed that our pflaplace function will fail when our
% poles have imaginary part. So, could you please modify our pflaplace.m
% function, so that it can works well for those poles with imaginary part
% as inverse laplace?
% One more thing, all of these examples are about one-side laplace, these
% signal are all multiplied by u(t) signal.
% In addition, from our last week's example:
% x(t) = e^{-t}u(t) + e^{2t}u(-t), we can find out that ROC is related with
% the multiplied term is u(t) or u(-t).
% If we have a X(s) = -3 / [(s+1)(s-2)]. Obvioulsy, its poles are -1 and 2.
% However, the ROC actually depends on each term multiplied by u(t) or
% u(-t)
% Let us consider all case. 
% X(s) = 1/(s+1) - 1 / (s - 2)
% This means that Res(X(s)exp(st), -1) = exp(-t) and Res(X(s)exp(st), 2) =
% exp(2t).
% Therefore, the whole space can be devided into 3 section.
% Re(s) > 2; 
% -1 < Rs(s) < 2;
% Re(s) < -1
% And obviously, different ROC will be mapping to different finally x(t).
% Let us consider 4 type of u(t) and u(-t) combination
% x(t) = exp(-t) u(t) - exp(2t) u(t)  -> 0 < |L| = 1/(Re(s)+1) - 1 / (Re(s)-2)
% < inf ==> Re(s) > -1, Re(s) > 2 ==> Re(s) > 2
% x(t) = -exp(-t) u(-t) - exp(2t) u(t) -> 1/(s+1) +
% 1/(s+1)exp(-(s+1)-\infty) - 1/(s - 2) ==> s < -1 & s > 2  == fail!
% x(t) = exp(-t) u(t) + exp(2t) u(-t) -- > 1 / (s + 1) + 1 / (2-s) -
% 1/(2-s) exp((2-s)-\infty) ==> s > -1 & s < 2 == ROC -1 < Rs(s) < 2;
% x(t) = -exp(-t) u(-t) + exp(2t) u(-t) --> 1/(s+1) +
% 1/(s+1)exp(-(s+1)-\infty) + 1 / (2-s) - 1/(2-s) exp((2-s)-\infty) ==> s <
% -1 & s < 2 ==> ROC Re(s) < -1
