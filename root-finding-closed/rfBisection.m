function [xr] = rfBisection(fun,xl,xu,TolX)
%Usage: function xr = bisection(fun,xl,xu,TolX)
%given the function handle for an external function, a lower lim, an upper
%lim and the error tolerance, this function approximates the root xr using
%the bisection algorithm.
%This function finds the root of a function f(x) = 0 using the biection
%algorithm.
% find value of function at the high and low vals of X
Y_low = fun(xl);
Y_high = fun(xu);
% if the interval does not definitely cross x-axis, there is no root
if (Y_low * Y_high > 0)
    error('bounds do not contain root');
end
count = 1;
while(true) 
    xr = 0.5*(xu + xl); %bisect the bounds to approximate root
    Y_root = fun(xr); %evaluate function at root
    rerr = abs((xu - xl)./(xl + xu)); %find the relative error to compare to tolerance
    if rerr < TolX
         return; %if the root is within tolerance, exit the function
    end
    if Y_low * Y_root < 0
        xu = xr; %if the approx root is the upper bound, it crosses the x axis and has a different sign
    else
        xl = xr; %else it is the new lower bound
        Y_low = fun(xl);
    end
   fprintf('\nIteration: %4d\nxl = %5.3f\nxu = %5.3f\nxr = %5.3f\nFunc Value = %5.3f\n',count,xl,xu,xr,Y_root)
   count = count + 1;
end