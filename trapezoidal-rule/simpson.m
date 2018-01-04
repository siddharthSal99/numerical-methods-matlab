function [result,error] = simpson(xdata,ydata)
if mod(length(xdata),2) ~= 0
    error('must have even number of data pts');
end
result = [];
error = [];
for n = 1:length(xdata) - 2
    x1 = xdata(n);
    x2 = xdata(n + 1);
    x3 = xdata(n + 2);
    h = x3 - x2;
    f1 = ydata(n);
    f2 = ydata(n + 1);
    f3 = ydata(n + 2);
    result = [result , result + (1/3) * h * (f1 + 4*f2 + f3)];
    error = 
end



end
