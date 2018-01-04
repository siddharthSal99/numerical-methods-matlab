function f = stepFunction(x,nterms)
%f(x) = sum from k = 1 to nterms of (4/pi)*Sum(sin(n*pi*x)/n)

sum = zeros(1,length(x));
for k = 1:nterms
    n = 2*k - 1;
    vec = sin((n).*pi.*x);
    sum = sum + (vec./(n));
end
f = (4/pi).*sum;

end
