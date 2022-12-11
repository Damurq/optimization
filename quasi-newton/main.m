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
    Prueba del Quasi-Newton con Wolfe
    Inputs:
        f: Función en formato string.
        x0: Punto inicial en forma de vector fila.
        dom: Dominio permitido (se sugiere [0, Inf] para Wolfe.)
        tol: Tolerancia aceptada.
        maxIter: Cantidad máxima de iteraciones.
        linearSearch: Tipo de búsqueda lineal;
            1) Bisección (Hay que adaptar).
            2) Wolfe.
    Outputs:
        x: Punto mínimo obtenido.
        fx: Valor mínimo obtenido.
%}
f = '9*(x-12)^2+10*(y-15)^2';
x0 = [1, 1];

tol = 1e-6;
maxIter = 5;

linearSearch = 'Wolfe';

dom = [0, Inf];

[x, fx] = QuasiNewton(f, x0, dom, tol, maxIter, linearSearch);

disp(double(x));
disp(double(fx));
