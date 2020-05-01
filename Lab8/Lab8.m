% Follow Professor's course, let us discuss the Fourior transform today.
% In this lab section, the connection between Laplace and Fourior trasforms
% will be highlighted for computational and analytical reasons. The Fourior
% transform turns out to be a very important case of the Laplace transform
% whose ROC contains the jy axis.
% An aperiodic/nonperiodic signal x(t), can be thought as a periodic signal with infinite period. 
% Therefore, we can also have the mapping relationship
% x(t) <=> X(w), where the \Omega means signal is projected into frequency
% domain.
% Firstly, let us remember the form of Fourior transform, a little
% different from Laplace.
% x(t) = 1/2pi * \int_{-\infty}^{\infty}X(w)exp(jwt)dw.
% X(w) = \int_{-\infty}^{\infty} x(t) exp(-jwt)dt
% Above means that if X(w) exist;
% |X(w)| < \infty <=> \int_{-\infty}^{\infty} x(t) exp(-jwt)dt < \infty.
% In which x = 0, so this implies that ROC of function must contains x = 0,
% across imaginary axis.
% For example,
% x(t) = u(t); unit-step function, we have the 
% X(s) = 1/s; s= 1 is a pole, so it cannot be used to find Fourior
% x(t) = exp(-2t)u(t);
% X(s) = 1/(s+2);
% |X(s)| < \infty <=>\int_0^{\infty}exp(-(2+x)t)dt < \infty 
% So we have x-2>0 ==> x>-2; ROC is x+jy| x> -2, so ROC contains the jy.
% Then, we can get the Fourior transform.
% X(w) = 1/(2+jw)
% Directly, since the Fourior transform is similar to Laplace transform, it
% is also linearity.
% Also, we can view the inverse property between Time and Frequency via
% Fourior transform.
% dirac(t) --> 1 (one support --> everywhere on frequency)
% A  --> 2\piA\dirac(w) (everywhere on time --> one support on w.
% So Fourior transform can only view as the laplace transform where
% s == jw.
% For example,
% x(t) = A(u(t+a) - u(t-a)) 
% From linearity, its Laplace transform is
% X(s) = A/s(exp(as) - exp(-as));
% |X(s)| = \int_{0}^2 |exp(x+jy)|t dt = \int exp(x)dt < \infty.
% Therefore, ROC(x) == [-\infty, \infty]; Obviously, jy is included in this
% region. So we have the Fourior transform by subsitituting s = jw
% Let us code this example in matlab if A = 1, a = 0.5
% In matlab, we have provided fourier to calculate this.
syms t w;
x = heaviside(t+0.5) - heaviside(t-0.5);
figure(1);
subplot(211);
fplot(x, [-3 3]); axis([-3 3 -0.1, 1.1]); grid;
X = fourier(x);
subplot(212);
fplot(X, [-50 50]); axis([-50 50 -1 5]); grid;
% So this can be treated as a pectrum of x on the frequency domain. Because
% we focus only on different frequency.
% In addition, if u change the offset in heaviside function, we can check
% the inverse propoerty, when the signal ontracts in time it expands in
% frequency.

% Then, let us do a summary, if you want to compute the Fourior transform,
% there are 3 methods
% (1), Find their Laplace transform as we did before, use the laplace to
% get X(s), and then, substitute s with jw.
% (2), Using fourier function as we did in previous example.
% (3), Sampling x(t) using the sampling theory (We will discuss this later)

% Example using matlab to compute Fourier and then get magnitude and phase.
% x(t) = exp(-t)u(t);
% |X| = sqrt(Re(X)^2 + Im(X)^2)
% Phase(X) = Im(log(X))
syms t;
x = exp(-t) * heaviside(t);
X = fourier(x);
Xm = sqrt((real(X))^2 + (imag(X))^2);
Xp = imag(log(X));
% Xp = atan(imag(X) / real(X));
% Xp = atan2(imag(X), real(X));
figure(2);
subplot(311);
fplot(x, [-1 5]); axis([-1 5 -0.2 1.2]); xlabel("$$t(sec)$$", "interpreter", "latex"); grid;
ylabel("x(t)", "Interpreter",'latex');
subplot(312);
fplot(Xm, [-30 30]); axis([-30 30 -0.2 1.2]); xlabel("$$\Omega$$", "interpreter", "latex");
ylabel("$$|X(\Omega)|$$", "Interpreter",'latex'); grid;
subplot(313);
fplot(Xp, [-30 30]); axis([-30 30 -pi pi]); xlabel("$$\Omega$$", "interpreter", "latex");
ylabel("$$\angle(X(\Omega))$$", "Interpreter",'latex'); grid;
% Therefore, when our w increase, the magnitude in Fourier transform
% decrease as shown in figure 2, this is called a low-pass filter, which
% means that the signal only concentrate in the low frequency.


% So today's assignment
% If we have a signal y(t) = exp(-|t|)cos(w_0t), we have
% Firstly, the exp(-|t|) --> laplace as follow,
% \int_{-\infty}^0 exp(t)exp(-jwt)dt + \int_{0}^{\infty} exp(-t)exp(-jwt)dt
% = 1/(1-s) + 1/(1+s) | s = jw;
% X(w) = 1/(1+w^2)
% cos(w_0t) = exp(jw0t) + exp(-jw0t)
% So we have the 
% X(w) = 1 / (1 - s + jw0) + 1 / (1 - s - jw0) + 1 / (1 + s + jw0) + 1 / (1
% + s - jw0), if s = jw
% X(w) = 1 / (1 + (w + w0)^2) + 1 / (1 + (w - w0)^2)
% Assignment is
% 1. Please complete ther proof above, then use matlab to prove this is
% correct.
% 2. For our X(w), please write down their explicit magitude and phase.
% 3. Plot out them and then analysis the property of this function. 


% extra : as we see the method 1,we can derive fourioer transform by substituting s with jw in laplace, 
% can you modify our pflaplace before to write  out the fourier function
