clc
fx = '(-2)*x*y-2*y+x^2+y^2';
initial = [0; 0];
tolerance = 0.00000000001;
maxIter = 10;
prueba = Cauchy(fx, initial, tolerance, maxIter);