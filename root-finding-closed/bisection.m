function xr = bisection(fun,xl,xu,TolX)
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
    error('Bounds do not contain root');
end
%main loop to approach root
while(true) 
    xr = 0.5*(xu + xl); %bisect the bounds to approximate root
    Y_root = fun(xr); %evaluate function at root
    rerr = abs((xu - xl)./(xl + xu)); %find the relative error to compare to tolerance
    if rerr < TolX
        return; %if the root is within tolerance, exit the function
    end
    if Y_low * Y_root < 0
        xu = xr; %if the approx root is the upper bound, it crosses the x axis and has a different sign
    elseif Y_root < 2*eps
        return; %just in case the bisection found the root exactly
    else
        xl = xr; %else it is the new lower bound
        Y_low = fun(xl);
    end
end


end