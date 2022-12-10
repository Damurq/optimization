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


function c = biseccion(f, var, x0, d2, tol, maxIter)
%Busqueda biseccion

%{
        Inputs:
            f: Función en formato string.
            var: variables de la funcion en forma de vector fila [x y]
            x0: Punto inicial en forma de vector fila.
            d: Dirección de descenso en forma de vector.
            tol: Tolerancia aceptada.
            maxIter: Cantidad máxima de iteraciones.
        Outputs:
             a: Extremo inferior. Se sugiere 0.
            b: Extremo superior. Se sugiere 1.
    %}

% Se declaran e inicializan las variables a utilizar
k=0;
a=0;
b=1;

% Inicia el ciclo iterativo...
while abs(b-a)>=tol && k<=maxIter
    %se calcula el punto medio del intervalo [a b]
    c=(a+b)/2;
    %se calcula el punto del intervalo [a b]
    cal=x0+c*d2;
    
    %se calcula y evalua el gradiente en el punto obtenido cal
    gradientf_k  = gradientef(f, var, cal);
    
    %se calcula la direccion de desenso por el gradiente en el punto cal obteniendo como resultado un punto
    cond=d2*gradientf_k;
    
    %se evalua la condicion calculada para redefinir el intervalo
    if cond>0
        b=c;
        %{
            Se evalúa que;
            - si el numero que calculamos que estamos
            utilizando como condicion es mayor a cero, positivo, entonces
            redefinimos el extremo superior y lo igualamos al punto medio c
        %}
    elseif cond<0
        a=c;
        %{
            Se evalúa que;
            - si el numero que calculamos que estamos
            utilizando como condicion es menor a cero,negativo, entonces
            redefinimos el extremo inferior y lo igualamos al punto medio c
        %}
    end
    % Se actualiza el valor de k para la siguiente iteración.
    k=k+1;
end
end