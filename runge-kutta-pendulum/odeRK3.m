function y = odeRK3(dydx,x,y0)
% dydx is the function handle for the ode function that defines the derivatives dy/dx
%x is a row vector of x-values to integrate on
% y0 is a column vector of initial conditions for this ode. 
y = zeros(length(y0), length(x));
y(:,1) = y0;

for i = 1:length(x) - 1
    h = x(i + 1) - x(i);
    k1 = dydx(x(i), y(:,i));
    k2 = dydx(x(i) + h/2,y(:,i) + k1*h/2);
    k3 = dydx(x(i) + h, y(:,i) - k1*h + 2*k2*h);
    
    phi = (k1 + 4*k2 + k3) / 6; 
    y(:,i + 1) = y(:,i) + phi * h;
end
end