function y = fm(x, t)
    N = length(t);
    y = zeros(1, N);
    for i = 1:N
        y(i) = cos(2 * pi * t(i) + 2 * pi * integral(x, 0, t(i), 1e-5));
    end
end