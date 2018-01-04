function [r] = rootTangent()
%returns the first and 5th roots of a function.
fun = @(x) x - 5*tan(x); %anonymous function handle to define the function
xRange = linspace(0,20,10000); %interval of points to calculate the function
yRange = fun(xRange);%yvalues for the func.
figure
plot(xRange,yRange)
hold on
plot(linspace(0,20),zeros(1,100));
axis([0,20 -100 100]);
xlabel('lambda');
ylabel('f(x) = x - 5*tan(x)');
grid on
r  = [];
xr1 = rfBisection(fun,3.78,3.8,10.^-8); %use the bisection algorithm to find the root
xr5 = rfBisection(fun,16.99,17,10.^-8);

fprintf('First Root: %10.8f\nFifth Root: %10.8f\n',xr1,xr5);
r = [xr1,xr5]; %return the 1st and 5th roots
end