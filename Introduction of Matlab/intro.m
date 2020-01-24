% introduction of matlab
% please make sure func.m and intro.m files are in same folder
clear all;
clf;
% row vector
x = [1 2 3 4];  % define a row vector
y = x';         % transpose row-vector to column-vector

% We can view our existing variables in the workspace
% and use the commend whos also can provide us information of them
whos

% From our first example, we can notice that a vetor is thought of as a
% matrix. Therefore, another way to express the column vector y is as
% following; we can use semicolon ; to seperate each of the row term
y = [1;2;3;4];

% Be different with traditional C or C++ code you studied before, Matlab do
% es not allow arguments of vectors of matrices to be zero or negative. So,
% Matlab's indices of vectors or matrices start at zeros.
% For example; first element of y is
y(1)

% For convinience, Matlab also supports slice operation of vectors or
% matrices.
% First to third entry of column vector y
y(1:3)

% also, slice operation can be defined as skip-space of slice.
% For example, if we want y(4), y(2), we can us
y(4:-2:1)

% Matrices in matlab can be constructed as an concatenation of rows
A = [1 2;3 4;5 6]

% combination of vectors in Matlab
n1 = 0:10;
n2 = 1:2:10;
n = [n1 n2]

% Matlab also allows the convetional vectorial operations; For example
% elementwise multipled by number 3 for the row-vector/col-vector
z = 3 * x;
w = 3 * y;

% In addition, Matlab allows two-type vector multiplication
% First, for two vector of 
z = x .* x;
z = x .^2;

% Second, we can have standard matrix muiltiplication, if two vectors or
% matrices's dimension is compatible. For example, in next 2 cases, the
% column size of x should be coincide with row size x'
z = x * x';
z = x' * x;

% If u want to get solustion of linear equation in matlab, it also very
% simple. For example, if we solve the linear equation Ax = b; Where A is
% 3 x 3 matrix
A = [1 0 0; 2 2 0; 3 3 3];
b = [2 2 2]';

% First, we need to gurantee that a unique solution exists, if you have
% take linear algebra, we will make sure the determinant of the matrix A
% should be computed and it is not zero. We always say the matrix is
% singular if its determinant equals to zero. So, in linear equation, we
% should make sure that A is not singular.
t = det(A);

% Then, we can solve linear equation by inverting matrix A
x = inv(A) * b;
x = A \ b;   %% backslash is faster and more accurate in matlab;

% Then solve polynomial function e.g x^2-x-1 = 0
% This will be very useful when we discuss the zeros and pols for a laplace
% transform
p = [1 -1 -1];
r = roots(p);

% Matlab has created a lot build-in functions for us. And it also allows us
% to create our own function
% function y = func(x)
% y = x * exp(-sin(x))/(1 + x^2)
% However, matlab itself does not allow us declare function directly inside
% the script, if u want to create a self-defined function, please create
% and save it in a extension m file with same function name
% and then if matlab detect the corresponding function file in current work
% folder. we can excute it. For example
x = 0:0.1:100;
n = length(x);
y = zeros(1, n);  %% create y matrix of dimension 1 x N
for i = 1:n
   y(i) = func(x(i)); 
end
% anonymous function
f2 = @(x) 1 ./ x - (x - 1);
y2 = zeros(1, n);  %% create y matrix of dimension 1 x N
for i = 1:n
   y2(i) = f2(x(i)); 
end
% plot function ez way use ezplot/fplot 
% the difference between * and .*
figure(1);
%ezplot(f2, [0, 4]);
fplot(f2, [0, 4]);
axis([0 4 -3 7]);
phi1 = fzero(f2, 1);
hold on;
plot(phi1, 0, 'o');
% Then with the data generated from your own function, we can plot them
% like this, using build-in function plot.
figure(1);   % 1, 2, 3 represent figure id
plot(x, y);
grid;        % using grid function to display hidden axes lines
% Then, u can title your figure, in matlab, it supports latex grammer, and
% so, you can write your title like this.
title('$$x\frac{e^{-\sin{(x)}}}{1+x^2}$$','interpreter','latex')
% Finally, name x-axis label and y-axis labelsyms t y z;   % define symbolic variables
y = cos(t^2);   % this is original function
z = diff(y);    % derivative 
figure(2)
subplot(211)
fplot(y, [0, 2*pi]); grid;  % use build-in function fplot to plot function 
title('$$\cos{(t^2)}$$', 'interpreter', 'latex')
hold on;
subplot(212)
fplot(z, [0, 2*pi]); grid;
title('$$\frac{dy}{dt}$$', 'interpreter', 'latex')
hold on;
% For comparison, we can use stem to plot computational derivative for
% cos(t^2); we we use build-in function `stem` here to plot these discrete
% point
ts = 0.1;     %% defined computation delta
t1 = 0:ts:2*pi; %% where pi is build-in constant pi.
y1 = cos(t1.^2);
z1 = diff(y1) ./ diff(t1);
figure(2);
subplot(211);
stem(t1, y1, 'b');  % where 'r' means discrete point with red color
axis([0 2*pi 1.1 * min(y1) 1.1 * max(y1)]);
subplot(212)
stem(t1(1:length(y1)-1), z1, 'r');  % where 'r' means discrete point with red color
axis([0 2*pi 1.1 * min(z1) 1.1 * max(z1)]);
legend('Derivative', 'Difference')
hold off;
xlabel('x')
ylabel('y')

% We have considered the numerical capabilities Matlab, by which numerical
% data are transformed into numerical data. For example. x --> y in func.
% But there will be many situations when we would like to do algebraic or
% calculus operations rather than numerical data
% For example, we want to get complex derivative or integral. For those
% cases, matlab provides us Symbolic math Toolbox. For example
% get derivative of cos(t^2) w.r.t. variable t
syms t y z;   % define symbolic variables
y = cos(t^2);   % this is original function
z = diff(y);    % derivative 
figure(2)
subplot(211)
fplot(y, [0, 2*pi]); grid;  % use build-in function fplot to plot function 
title('$$\cos{(t^2)}$$', 'interpreter', 'latex')
hold on;
subplot(212)
fplot(z, [0, 2*pi]); grid;
title('$$\frac{dy}{dt}$$', 'interpreter', 'latex')
hold on;
% For comparison, we can use stem to plot computational derivative for
% cos(t^2); we we use build-in function `stem` here to plot these discrete
% point
ts = 0.1;     %% defined computation delta
t1 = 0:ts:2*pi; %% where pi is build-in constant pi.
y1 = cos(t1.^2);
z1 = diff(y1) ./ diff(t1);
figure(2);
subplot(211);
stem(t1, y1, 'b');  % where 'r' means discrete point with red color
axis([0 2*pi 1.1 * min(y1) 1.1 * max(y1)]);
subplot(212)
stem(t1(1:length(y1)-1), z1, 'r');  % where 'r' means discrete point with red color
axis([0 2*pi 1.1 * min(z1) 1.1 * max(z1)]);
legend('Derivative', 'Difference')
hold off;

% intrgration
zz = zeros(10);
syms t z;
for k = 1:10
   z = 2 * int(sinc(t)^2, t, 0, k); % integral of [sin(pi*t)/(pi * t)]^2 on 0 to k
   zz(k) = subs(z);     % subs copy our symbolic result z and store it as a vector element
end
figure(4);
t1 = linspace(-4, 4);
y = 2 * sinc(t1).^2;
n = 1:10;
subplot(211)
plot(t1, y); grid;
subplot(212);
stem(n(1:10), zz(1:10)); hold on;
plot(n(1:10), zz(1:10), 'r'); grid;
hold off;

% Finally, we give u a example of computing the response of a differential
% equation
% Given that we have a ODE
% \frac{d^2 y(t)}{dt^2} + 5 \frac{d y(t)}{dt} + 6 y(t) = x(t);
syms y t x z;
% Then we use dsolve to solve this function
y = dsolve('D2y+5*Dy+6*y=1','y(0)=0', 'Dy(0)=0', 't');
x = diff(y);   %% impulse
z = int(y);    %% ramp
figure(5);
subplot(311);
fplot(y, [0, 5]); grid; title('Unit-step reponse');
subplot(312);
fplot(x, [0, 5]); grid; title('Impulse response');
subplot(313);
fplot(z, [0, 5]); grid; title('Ramp response');


% In addition, for Matlab, the best tutorial is the document provided by
% Matlab. So, if you have any problem, do not be afraid, and try to search
% the under the document of Matlab in Mathworks: Here is the website:
% https://www.mathworks.com/help/matlab/index.html

% Recursive funtion factorial
fact(1)
% timer for a function
tic, fact(20), toc

fern

