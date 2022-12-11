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
function [xn, fval] = AnotherWolfe(f, x0, a, b, maxIter, tol)
    % Método alternativo de condiciones de Wolfe.
    %{
        Inputs:
            f:      Función a evaluar en formato symbolic.
            x0:     Punto inicial en el que se evaluará las condiciones de
                    Wolfe en formato vector fila.
            a:      Extremo inferior en formato double.
            b:      Extremo superior en formato double.
            tol:    Tolerancia aceptada.
            maxIter:Cantidad máxima de iteraciones a ejecutar.
    %}
    % Inicializa el punto inicial y el gradiente en ese punto
    
    syms x y z;
    xn = x0;
    
    g = gradient(f, [x y]);
    gx = subs(g,{x,y},{xn(1),xn(2)});
    
    % Se declaran los valores de c1 y c2.
    c1 = 1e-4;
    c2 = 0.9;

    % Inicializa el número de iteraciones
    iter = 0;

    % Repite hasta que se alcance el número máximo de iteraciones
    while iter < maxIter && norm(gx) > tol
        % Calcula el tamaño del paso
        alpha = 1;

        % Calcula la dirección de descenso
        p = -gx;

        % Calcula el punto de evaluación
        x1 = xn + alpha * p;

        % Calcula la función de costo en el punto de evaluación
        fxn = subs(f,{x,y},{xn(1),xn(2)});
        fx1 = subs(f,{x,y},{x1(1),x1(2)});

        % Verifica si se cumplen las condiciones de Armijo
        if fxn - fx1 >= c1 * alpha * dot(gx, p)
            % Si se cumplen las condiciones de Armijo, se comprueban las
            % condiciones de Wolfe
            gx1 = g(x1);

            if dot(gx1, p) >= c2 * dot(gx, p)
                % Si se cumplen las condiciones de Armijo y de Wolfe, se
                % acepta el nuevo punto y se sale del bucle
                xn = x1;
                gx = gx1;
                break;
            else
                % Si no se cumplen las condiciones de Wolfe, se reduce el
                % tamaño del paso y se vuelve a calcular el punto de
                % evaluación
                alpha = alpha * b;
                x1 = xn + alpha * p;
                fx1 = subs(f,{x,y},{x1(1),x1(2)});
                gx1 = subs(g,{x,y},{x1(1),x1(2)});
            end
        else
            % Si no se cumplen las condiciones de Armijo, se reduce el
            % tamaño del paso y se vuelve a calcular el punto de evaluación
            alpha = alpha * b;
            x1 = xn + alpha * p;
            fx1 = subs(f,{x,y},{x1(1),x1(2)});
            gx1 = subs(g,{x,y},{x1(1),x1(2)});
        end

        % Actualiza el punto de inicio y el gradiente en ese punto
        xn = x1;
        gx = gx1;
        fval = fxn;

        % Incrementa el número de iteraciones
        iter = iter + 1;
        
        % Se evalúa el nivel de tolerancia
        if norm(gx) <= tol
            xn = x1;
            fval = fxn;
            break
        end
    end
    
    
end