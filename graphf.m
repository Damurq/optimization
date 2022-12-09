function graph = graphf(f,xx,yy, xi, x0)

    domain = [xx yy];
    graph = fsurf(f, domain);
    xlabel('Eje x');
    ylabel('Eje y');
    zlabel('Eje z');
    fstr = string(f);
    title(['Funcion: ' fstr],'FontSize',12);
    box on;
    rotate3d;
    grid on;
    hold on;
    plot3(xi(1),xi(2),0,'o', 'MarkerFaceColor',[0.9290 0.6940 0.1250],'MarkerSize',12);
    hold on;
    plot3(x0(1),x0(2),0,'o', 'MarkerFaceColor',[0.6350 0.0780 0.1840]);
    legend('Funcion' ,'Punto inicial', 'Punto optimo','FontSize',12);
    title(legend, 'Leyenda','FontSize',12);
    
    

end