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

%{
    Parámetros de entrada:
    - f :   Función en formato symbolic.
    - x0:   Punto inicial.
    - d :   Dirección de descenso.
%}
function t = Wolfe(f, x0, d)
    
    % Se declaran e inicializan las variables a utilizar.
    syms x y;
    
    k = 0;

    c1 = 0.5;
    c2 = 0.75;
    
    alpha = 0;
    beta = Inf;
    
    t = 1;
    
    % Se calcula el gradiente de la función pasada y su transpuesta 
    % como parámetro.
    grad = gradient(f, symvar(f));
    gtrasp = transpose(grad);
    
    % Encabezado de resultados %
    show = sprintf("%13s","Iteración (k)","Alfa","Beta","t");
    fprintf('%s\n', show);
    disp('____________________________________________________');
    
    % Inicia el ciclo iterativo...
    while true
        
        % Se evalúa función y transpuesta en el punto.
        fp = subs(f, {x,y}, {x0(1), x0(2)});
        gtp = subs(gtrasp, {x,y}, {x0(1), x0(2)});
        
        % Se obtiene el punto siguiente.
        ptd = x0 + t * d;
        
        % Se evalúa la función en el punto siguiente.
        fnext = subs(f,{x,y},{ptd(1), ptd(2)});
        gnext = subs(grad,{x,y},{ptd(1), ptd(2)});
        
        %disp(fnext);
        %disp((c1 * t * gtp * d));
        %disp(c1 * t * d' * gtp');
        
        %{
            Se evalúa que;
            - Si la función evaluada en el siguiente punto siguiente
                es mayor que la función evaluada en el punto más el
                producto de c1 (0.5) por el valor de t, el gradiente
                transpuesto evaluado en el punto y la dirección de
                descenso, entonces se actualiza beta a un valor t y, t
                a (1/2) por la suma de alpha y beta.
        %}
        if (fnext > (fp + (c1 * t * gtp * d)))
            beta = t;
            t = (1/2) * (alpha + beta);
            
        %{
            - Para el caso contrario;
                * Se evalúa que el gradiente transpuesto evaluado en el
                    punto siguiente por la dirección de descenso, sea menor
                    que el producto de c2 (0.75) por el gradiente
                    transpuesto evaluado en el punto y la dirección de
                    descenso. De ser el caso, se actualiza alpha a t y;
        %}
        else
            
            if ((gnext' * d) < (c2 * gtp * d))
                
                alpha = t;
                
                %{
                    -> Si beta es igual a +infinito, entonces t es igual a
                        dos veces alpha.
                %}
                if (beta == Inf)
                    t = 2 * alpha;
                    
                %{
                    -> Caso contrario, t sería (1/2) por la suma de alpha y
                        beta.
                %}
                else
                    t = (1/2) * (alpha + beta);
                end
                
            %{
                * Caso contrario, retorna el valor de t, el cual es el
                    valor que satisface las condiciones de Wolfe, siendo
                    este el tamaño de paso.
            %}
            else
                show = sprintf('%13.3f', k, alpha, beta, t); % Obtiene los resultados del paso %
                fprintf('%s\n', show); % Muestra los resultados del paso %
                t = double(t);
                
                disp('Se consiguió un t óptimo: ')
                disp(t);
                
                return;
            end

        
        end
        
        show = sprintf('%13.3f',k,alpha,beta,t); % Obtiene los resultados del paso %
        fprintf('%s\n', show); % Muestra los resultados del paso %
        
         % Se actualiza el valor de k para la siguiente iteración.
        k = k+1;
        
        % Se alcanza el máximo de iteraciones, por lo que se culmina el
        % algoritmo.
        if (k > 250)
            disp('Se alcanzó la cantidad máxima de iteraciones (250)')
            disp('Último t obtenido: ');
            disp(t);
            
            % Devuelve el último valor t obtenido % 
            t = double(t);
            return;  
        end
    end   
end

