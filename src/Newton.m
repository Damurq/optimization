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
function x0 = Newton(fx, initial, tolerance, maxIter, busquedaLineal, xx, yy)
    % Método para ejecutar el algoritmo de Newton.
    %{
        Inputs:
            fx: Función en formato string.
            initial: Punto inicial en forma de vector fila.
            tolerance: Tolerancia aceptada.
            maxIter: Cantidad máxima de iteraciones.
            busquedaLineal: Tipo de búsqueda lineal como string;
                Bisección
                Wolfe.
                Despeje
            xx: Intervalo del eje x en forma de vector fila
            yy: Intervalo del eje y en forma de vector fila
        Outputs:
            x0: Punto mínimo obtenido.
            Fx: Valor mínimo obtenido.
    %}
    
    %se declaran las variables simbolicas
    syms x y;

    f = str2sym(fx);%convierte la funcion de formato string a funcion simbolica
    var = symvar(f);%extrae las variables de la funcion f y crea un vector fila con ellas
    
  % Se declaran e inicializan las variables a utilizar.
    x0 = initial;
    xi=x0;
    
    tol = tolerance;
    
    alfa = 1;
    a = 0;
    b = inf;
    
    k = 0;
    
    %se calcula y evalua el gradiente de la funcion en el punto
    gradientf_k  = gradientef(f, var, x0);
    
    %se calcula y evalua la hessiana de la funcion en el punto
    hessianf_k = hessianof(f,var,x0);
    
    
    
    
    if norm(gradientf_k) == 0
        
        foptimal = subs(f,var,x0);%evalua el punto inicial en la funcion para obtener el valor optimo
        %imprimir resultados por consola
        fprintf('\nel punto optimo es el punto inicial: (%1.3f,%1.3f) \n', x0(1),x0(2));
        fprintf('\nel valor optimo es %1.3f \n', foptimal);
        
        %{
            Se evalúa que;
            - si la norma del gradiente de la funcion es igual a cero
            entonces el algoritmo converge y el punto incial es el punto
            optimo y se imprimen los resultados por consola
        %}
        
    else
        %{
            Se evalúa que;
            - en caso contrario, si la norma del gradiente de la funcion es distinto de cero con el punto 
            inicial entonces comienza
        %}
        
        %imprimir tabla resultado por consola
        fprintf('k \t\t punto \t\t alfa \t\t dir.descenso \t norma \n');
        fprintf('__________________________________________________________________\n');
        
          % Inicia el ciclo iterativo...
        while norm(gradientf_k ,'inf') >= tol && k<=maxIter
    
            %calcular la direccion de descenso mediante resolucion del
            %sistema de ecuaciones
            d = -hessianf_k\gradientf_k;
            
            
            % Se define un lambda óptimo para la iteración mediante las
            % busquedas lineas
            switch busquedaLineal
                case 'Despeje'
                    alfa = 1;
                case 'Bisection'
                    d2=transpose(d);
                    alfa = biseccion(f, var, x0, d2, tol, maxIter);
                case 'Wolfe'
                    alfa = Wolfe(f, x0, d, a, b, tol, maxIter);
            end
            
            
            
            %imprimir los resultados de las tablas de resultados de la
            %consola
            fprintf("%1.0f \t| (%1.3f,%1.3f) \t| %1.3f \t| (%1.3f,%1.3f) \t\t|  %1.3f \n",k,x0(1),x0(2),alfa,d(1),d(2),norm(gradientf_k));
            
            
            
            %se calcula el punto de la siguiente iteracion
            x1 = transpose(x0)+alfa*d;
            %se calcula la transpuesta
            x0 = transpose(x1);
            
            fila = [k, double(x0), double(alfa), double(transpose(d))];

            if k == 0
                table = fila;
            elseif k>0
                table = [table; fila];
            end
            
            % Se actualiza el valor de k para la siguiente iteración.
            k=k+1;
            
            %se calcula y evalua el gradiente de la funcion en el punto
            gradientf_k  = gradientef(f, var, x0);
            
            %se calcula y evalua la hessiana de la funcion en el punto
            hessianf_k = hessianof(f,var,x0);
        
        end
        %evalua el punto inicial en la funcion para obtener el valor optimo
        foptimal = subs(f,var,x0);
        %imprimir resultados por consola
        fprintf('\nel punto optimo es (%1.3f,%1.3f) \n', x0(1),x0(2));
        fprintf('\nel valor optimo es %1.3f \n', foptimal);
        
        
       
    end
    
    %llamar a la funcion para realizar la grafica pasando como parametros,
    %la funcion, el intervalo del eje x, el intervalo del eje y, el punto
    %inicial y el punto optimo
    graph = graphf(f, xx, yy, xi, x0);


    f = figure;
    t = uitable('ColumnName', {'iteración', 'x1', 'x2', 'alfa', 'd1', 'd2'});
    drawnow;
    set(t, 'Data', table);
    msgbox(['El punto óptimo x* es:  ', num2str(double(x0))])
    msgbox(['Y el valor óptimo es: f(x*)    :  ', num2str(double(subs(str2sym(fx),var,x0)))])
end