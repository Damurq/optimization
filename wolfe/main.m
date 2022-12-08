%{
    Para testear Wolfe:
        Solo requiere definir la función en la variable f
        y el punto inicial.
%}
clc

syms x y z;

f = 9*(x-12)^2+10*(y-15)^2;
g = gradient(f, symvar(f));
x0 = [1, 1];

gpt = subs(g, {x,y}, {x0(1), x0(2)});

disp(f);
disp(g);
disp(gpt);

Wolfe(f, x0, -gpt);