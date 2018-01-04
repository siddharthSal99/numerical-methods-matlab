%simpson's rule function calculates the numerical integral gven the
%function, an upper and lower bound and the number of subintervals
function [Q] = simp13_2(fun,a,b,n)
if(mod(n,2) ~= 0 || n <= 0) %error iff the subintervals is not even
    error('must be an even number')
end
if b < a
temp = b;
b = a;
a = temp;
end
xdata = linspace(a,b,n + 1); %find abscissa using the lower and upper bouds and the number of intervals
ydata = fun(xdata);%evluate function at each x point
h = (b - a)/n;
result = (ydata(1) + 4.*sum(ydata(2:2:end)) + 2.*sum(ydata(3:2:end - 2)) + ydata(end))* h/3;
Q = result;

end