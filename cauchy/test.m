fx = '9*(x-12)^2+10*(y-15)^2';
initial = [1;1];
tolerance = 0.00000000001;
maxIter = 2;
prueba = cauchy(fx, initial, tolerance, maxIter);