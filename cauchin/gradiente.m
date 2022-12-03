    %  f la función como string
    % 
    initial = [1;1];
    f = input('Introduzca la función ','s'); %Retorna un string
    sf = str2sym(f); %retorna una función
    v = symvar(sf); %retorna un vector fila con las variables Example [x,y]
    g = gradient(sf,v); % retorna un vector columna del gradiente
    d = -1*g
    disp(d);

    % Esto se puede usar para 
    % https://www.youtube.com/watch?v=7TWBZwnacWk
    % Despejar una variable de una ecuación en Matlab

