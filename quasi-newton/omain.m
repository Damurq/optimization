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
    Script para testear la otra alternativa para las condiciones de Wolfe.
%}
f = '9*(x-12)^2+10*(y-15)^2';
[f, vf, fs] = ReadFunction(f);
g = gradient(f, vf);


x0 = [1; 1];

a = 1;
b = 1;

maxIter = 10;

tol = 1e-4;

[x, fx] = AnotherWolfe(f, x0, a, b, maxIter, tol);

disp(double(x));
disp(double(fx));