%simpson's rule function calculates the numerical integral gven the
%function, an upper and lower bound and the number of subintervals
function [Q] = simp13(fun,a,b,n)
if(mod(n,2) ~= 0 || n <= 0) %error iff the subintervals is not even
    error('must be an even number')
end
xdata = linspace(a,b,n + 1); %find abscissa using the lower and upper bouds and the number of intervals
ydata = fun(xdata);%evluate function at each x point
result = 0;
for i = 1:2:length(xdata) - 2 
    %assign values to the three xdata points to fit the quadratic
    x1 = xdata(i); 
    x2 = xdata(i + 1);
    x3 = xdata(i + 2);
    h = x3 - x2; %find the interval spacing
    %assign values to the function values at the given data pts
    f1 = ydata(i);
    f2 = ydata(i + 1);
    f3 = ydata(i + 2);
    %add on the value to the simpsons rule calculation
    result = result + (1/3) * h * (f1 + 4*f2 + f3);
end

Q = result;

end