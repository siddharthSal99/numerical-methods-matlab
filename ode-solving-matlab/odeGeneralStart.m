function y = odeGeneralStart(dydx,x,y0)
%dydx is function of ode which takes in x as a scalar and y as a column
%vector of values
%x : row vector of x values
%y0: column vector of initial values
%y: output solution array (y0 by x)

y = zeros(length(y0), length(x));
y(:,1) = y0;

for i = 1:length(x) - 1
    h = x(i + 1) - x(i);
    phi = %calculation for phi
    y(:,i + 1) = y(:,i) + phi * h;
end
%% Euler's Method
%phi = dydx(x(i),y(:,i)); 
%y(:,i + 1) = y(:,i) + phi * h;


%% Huen's Method
%y(:,i + 1) = y(:,i) + dydx(x(i),y(:,i)) * h;
%phi = 0.5*(dydx(x(i),y(:,i)) + dydx(x(i + 1), y(:,i + 1)))
%y(:, i + 1) = y(:,i) + phi *h;


%% Midpoint Method
%yhalf = y(:,i) + dydx(x(i), y(:,i)) * 0.5 *h;
%phi = dydx(x(i) + 0.5*h, yhalf);
%y(:,i + 1) = y(:,i) + phi *h;

end