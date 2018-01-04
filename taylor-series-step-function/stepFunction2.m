function f = stepFunction2(x,nterms)
%returns the step function approximated by the taylor series using sine
%f(x) = sum from k = 1 to nterms of (4/pi)*Sum(sin(n*pi*x)/n)
%x is a row vector of x values to evaluate the function at
%nterms is the number of terms of the taylor series
%f is the value of the step function at the vectorized points
k = 1:nterms;
n = 2.*k - 1; %capture the odd values
n = n';
interm = (x.*n).*pi; %make a matrix holding the pairs of the sum for every value of x
vec = sin(interm) ./ n;
f = (4/pi).*sum(vec,1);

end