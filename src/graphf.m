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
function graph = graphf(f,xx,yy,xi, x0)
    % Método para mostrar gráfica de una función de tres variables.
    %{
        Inputs:
            f:      Función. P.ej.: @(x,y) sin(x)+cos(y)   - sym
            xx:     Intervalo del eje x en forma de vector fila
            yy:     Intervalo del eje y en forma de vector fila
            xi:     Punto inicial en forma de vector fila.
            x0:     Punto optimo en forma de vector fila.
        Outputs:
             graph: La grafica de la funcion
    %}

    %calcular el dominio con los intervalos ingresados por parametro
    domain = [xx yy];
    %graficar la funcion en el dominio especificado
    graph = fsurf(f, domain);
    %mostrar nombre de los ejes
    xlabel('Eje x');
    ylabel('Eje y');
    zlabel('Eje z');
    fstr = string(f);
    %mostrar titulo de la grafica con la funcion incluida
    title(['Funcion: ' fstr],'FontSize',12);
    %muestra el contorno del cuadro alrededor de los ejes 
    box on;
    %permite rotar la grafica
    rotate3d;
    %muestra las líneas de cuadrícula para los ejes 
    grid on;
    %conservar la grafica y permite graficar sobre ella los puntos
    hold on;
    %graficar el punto inicial
    plot3(xi(1),xi(2),0,'o', 'MarkerFaceColor',[0.9290 0.6940 0.1250],'MarkerSize',12);
    hold on;
    %graficar el punto optimo
    plot3(x0(1),x0(2),0,'o', 'MarkerFaceColor',[0.6350 0.0780 0.1840]);
    %mostrar la leyenda de la grafica
    legend('Funcion' ,'Punto inicial', 'Punto optimo','FontSize',12);
    %mostrar titulo de la leyenda
    title(legend, 'Leyenda','FontSize',12);
    
    

end