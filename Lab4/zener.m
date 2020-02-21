function y = zener(x)
    N = length(x);
    y = zeros(1, N);
    for i = 1:N
        if abs(x(i)) > 0.5
            y(i) = 0.5 * sign(x(i));
        else
            y(i) = x(i);
        end
    end
end