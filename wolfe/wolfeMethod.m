function a = wolfeMethod(func,point,d)
% Parámetros de salida:
% a = valor que satisface las condiciones de Wolfe.
% Parámetros de entrada:
% func = función objetivo.
% point = punto inicial.
% d = dirección de descenso.

% Inicialización de parámetros estáticos %
syms x y z;
k = 0;
c1 = 0.5;
c2 = 0.75;
alpha = 0;
t = 1;
beta = Inf;
show = sprintf("%13s","Iteración (k)","Alfa","Beta","t");
fprintf('%s\n', show);
fprintf('____________________________________________________');
while 1
    fptd = func(point + t * d); % Evaluar la función en el punto + t * d %
    fp = func(point); % Evaluar la función en el punto %
    g = gradient(func); % Calcular el gradiente de la función %
    gtrasp = transpose(g); % Trasponer el gradiente de la función %
    gtp = gtrasp(fp); % Calcular gradiente traspuesto de la función evaluada en el punto %
    if (fptd > (fp + (c1 *t*gtp*d))) % Evalúa la primera condición de Wolfe %
        beta = t; % Actualiza el valor de beta %
        t = (1/2)*(alpha+beta); % Actualiza el valor de t %
    else 
        gptd = gtrasp(fptd); % Evalúa el gradiente traspuesto de la función en el punto + t * d %
        if ((gptd*d) < (c2*gtp*d)) % Evalúa la segunda condición de Wolfe %
            alpha = t; % Actualiza el valor de alfa %
            if (beta == Inf) % Evalúa si beta es infinito %
                t = 2*alpha; % Si es infinito, t = 2 alpha %
            else 
                t = (1/2)*(alpha+beta); % Sino, t = 1/2 (alpha + beta) %
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
    if (k>249)
        fprintf('Se alcanzó la cantidad máxima de iteraciones (250)')
        a = t;
        return; % Devuelve el último valor t obtenido %  
    end
end