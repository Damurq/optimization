%{
 Optimización - 2022-2
  Trabajo computacional N°1
    Integrantes:
      - Brizuela, Yurisbellys. C.I: V-27.142.239
      - Manzano, Jesús. C.I: V-25.989.002
      - Miranda, Marihec. C.I: V-26.120.075
      - Montero, Michael. C.I: V-26.561.077
      - Rivero, Gustavo. C.I: V-26.772.857
      - Valladares, Luis. C.I: V-26.370.986
%} 
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