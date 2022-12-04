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

% Método de búsqueda lineal.
function l = LinearSearch(f, x, d, Fx, Gx)
    l=1; 
    alfa=10^(-1); 
    beta=0.1; 
    c=1; 
    while ((ObjectiveFunction(f, x+l*d)>Fx+alfa*l*Gx'*d) || (GradientFunction(x+l*d)'*d > beta*Gx'*d )) && c < 100 
        l=0.5*l; 
        c=c+1; 
    end
end