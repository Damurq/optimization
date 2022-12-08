%{
 Optimización - 2022-2
  Trabajo computacional N°1
    Integrantes:
      - Brizuela, Yurisbellys. C.I: V-27.142.239
      - Manzano, Jesús. C.I: V-25.989.002
      - Miranda, Marihec. C.I: V-26.120.075
      - Montero, Michael. C.I: V-26.561.077
      - Gustavo Rivero. C.I: V-26.772.857
      - Valladares, Luis. C.I: V-26.370.986
%}

clc

% Parámetros de salida:
% a     = valor que satisface las condiciones de Wolfe.

% Parámetros de entrada (input):
% f     = función objetivo en tipo de variable símbolo.
% vf    = variables que usa la función objetivo.
% fs    = función objetivo en tipo de variable función.
% a     = primera coordenada del punto inicial.
% b     = segunda coordenada del punto inicial.
% x0    = punto inicial en forma vector.
% point = punto inicial en forma punto.
% d     = dirección de descenso.

% Entrada de datos por pantalla %
% Se indica la función a optimizar.
[f, vf, fs] = ReadFunction('Indique la función a optimizar: ');

% Se indican el rango en el que se aplicará el algoritmo.
a       = input('Indique la primera coordenada del punto inicial: ');
b       = input('Indique la segunda coordenada del punto inicial: ');

% Se indica la dirección de descenso.
d       = input('Indique la dirección de descenso: ');

% Se declaran e inicializan las variables a utilizar;
% Punto inicial
x0      = [a,b];
point   = [a;b];

% Función iniciada en el punto [a,b]
fp      = fs(point);


% Inicialización de parámetros estáticos %
syms x y z;
k = 0;
c1 = 0.5;
c2 = 0.75;
alpha = 0;
t = 1;
beta = Inf;
grad = gradient(f,vf); % Calcular el gradiente de la función %
gtrasp = transpose(grad); % Transponer el gradiente de la función %

% Encabezado de resultados %
show = sprintf("%13s","Iteración (k)","Alfa","Beta","t");
fprintf('%s\n', show);
disp('____________________________________________________');

while 1
    fp = fs(point);
    gtp = subs(gtrasp,{x,y},{a,b}); % Calcular gradiente traspuesto de la función evaluada en el punto %
    ptd = double(point + t * d); % Evaluar la suma (x + t * d) %
    fptd = fs(ptd); % Evaluar la función en el punto + t * d %
    if (fptd > (fp + (c1 * t * gtp * d))) % Evalúa la primera condición de Wolfe %
        beta = t; % Actualiza el valor de beta %
        t = (1/2) * (alpha + beta); % Actualiza el valor de t %
    else 
        gptd = subs(gtrasp,{x,y},{ptd(1),ptd(2)}); % Evalúa el gradiente traspuesto de la función en el punto + t * d %
        if ((gptd * d) < (c2 * gtp * d)) % Evalúa la segunda condición de Wolfe %
            alpha = t; % Actualiza el valor de alfa %
            if (beta == Inf) % Evalúa si beta es infinito %
                t = 2 * alpha; % Si es infinito, t = 2 alpha %
            else 
                t = (1/2) * (alpha + beta); % Sino, t = 1/2 (alpha + beta) %
            end
        else
            a = t; % Asigna el valor t que satisface las condiciones de Wolfe %            
            show = sprintf('%13.3f',k,alpha,beta,t); % Obtiene los resultados del paso %
            fprintf('%s\n', show);
            return; % Devuelve el valor t que satisface las condiciones de Wolfe %  
        end
    end
    show = sprintf('%13.3f',k,alpha,beta,t); % Obtiene los resultados del paso %
    fprintf('%s\n', show); % Muestra los resultados del paso %
    k = k + 1; % Incrementa el contador de iteraciones %
    if (t<10^-6)
        disp('Se alcanzó la tolerancia mínima de paso (10^-6)')
        a = t;
        disp('Último t obtenido: ');
        disp(t);
        return; % Devuelve el último valor t obtenido %  
    end
end