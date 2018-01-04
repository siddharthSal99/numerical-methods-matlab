function Q = dint(fun,a,b,n,method)
if nargin == 4 %if method is not present, set to simpson's rule
    method = 'simp';
end

if n <= 0 %check if the subintervals is less than 0
	error('number of intervals must be >0');
end
if isequal(method,'simp') %check if the simpson's rule is not a multiple of 2
     if mod(n,2)
        error('Number of subintervals must be even');
     end
     %define problem parameters
     h = (b-a)/n;
     x = linspace(a,b,n+1);
     f = fun(x);
     Q = (f(1) + 4*sum(f(2:2:end-1)) + 2*sum(f(3:2:end-2)) + f(end))/3;
     Q = h*Q;
elseif isequal(method,'trap')
     h = (b-a)/n;
     x = linspace(a,b,n+1);
     f = fun(x);
     Q = 0.5*f(1) + sum(f(2:end-1)) + 0.5*f(end);
     Q = h*Q;
else
    error('Quadrature method is unsupported');
end

end