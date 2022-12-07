%clc
%fx = '(-2)*x*y-2*y+x^2+y^2';
%initial = [0; 0];
%tolerance = 0.00000000001;
%maxIter = 10;
%prueba = Cauchy(fx, initial, tolerance, maxIter);
fx = '9*(x-12)^2+10*(y-15)^2';
initial = [1; 1];
tolerance = 0.00000000001;
maxIter = 2;
prueba = cauchy(fx, initial, tolerance, maxIter);
