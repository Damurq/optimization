fx=input('Digite la función a optimizar: ', 's'); % Entrada de la funcion
initial = input("\nIngrese el punto inicial: ");
tolerance = input("\nIngrese la tolerancia: ");
maxIter=input("\nIngrese el numero maximo de iteraciones: ");

var = symvar(str2sym(fx));
n= numel(var);

if n==1
dd=zeros(1,n);
elseif n==2
    dir=input('\nIngresara la direccion de descenso? (1)SI (2)NO: ');
    
    if dir==1
        dd= input("\nIngrese la direccion de descenso: ");
    else 
        var = symvar(str2sym(fx));
        n= numel(var);
        dd=zeros(1,n);
    end
end

biseccion(fx, initial, tolerance, maxIter, dir, dd);