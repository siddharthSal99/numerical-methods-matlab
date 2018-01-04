function [result,error] = mousetrap(fun,xdata)
ydata = fun(xdata);
    for x = 1:length(xdata) - 1
        a = xdata(x);
        b = xdata(x + 1);
        fa = ydata(x);
        fb = ydata(x + 1);
        
        result = [result, result + 0.5 * (fa + fb) * (b - a)];
        error = [error, max(ydata(1:x)) * (b - a).^3 / (12 * length(xdata).^2)];
    end
end