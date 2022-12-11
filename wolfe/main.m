%{
    Para testear Wolfe:
        Solo requiere definir la función en la variable f
        y el punto inicial.
%}
clc

syms x y z;

f = 100*(y-x^2)^2+(1-x)^2;
g = gradient(f, symvar(f));
x0 = [-1.2, 1];
tol = 1e-6;
maxIter = 250;
dom = [0, Inf];
gpt = subs(g, {x,y}, {x0(1), x0(2)});

alpha = Wolfe(f, x0, -gpt, dom(1), dom(2), tol, maxIter);

disp(alpha);