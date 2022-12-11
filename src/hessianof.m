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
function Fhessian = hessianof(f,var,x0)
    % Método para calcular una matriz hessiana.
    %{
        Inputs:
            f:          Función en formato string.
            var:        Variables de la funcion en forma de vector fila [x y]
            x0:         Punto inicial en forma de vector fila.
        Outputs:
             Fhessian:  El hessiano evaluado en el punto
    %}

h = hessian(f, var);%se calcula la hessiana

n = numel(var); % Numero de variables

Fhessian=zeros(n,n); %Matriz para hessiano evaluado en el punto

    % Ciclo para calcular la hessiana evaluado en el punto
    for i=1:n
        for j=1:n
            fun=h(i,j);
            Fhessian(i,j)=subs(fun,var,x0);
        end
    end

end