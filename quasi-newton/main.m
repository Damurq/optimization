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
