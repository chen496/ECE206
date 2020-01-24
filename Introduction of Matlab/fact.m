function f = fact(n)
% Generate n * (n-1) *...* 1
if n <= 1
    f = 1;
else
    f = n * fact(n-1);
end
end