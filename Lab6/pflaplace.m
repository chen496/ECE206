function p = pflaplace(num, den)
    disp('zeros = ...');
    z = roots(num);
    disp(z);
    disp('poles = ...');
    [r,p,k] = residue(num, den);
    disp(p);
    disp('residues = ...');
    disp(r);
    syms x p t;
    x = poly2sym(r, t);
    p = subs(x, t, exp(-t));
    p = p * exp(-t);
end
