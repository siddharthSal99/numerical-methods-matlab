%% Formulae:
%   Trapezoidal: sum_1:n_{(h/2)*(f(x1) + f(x2))}
%               y_1 * 0.5 + y_end * 0.5 + sum(y(2:end - 1))
%   Simpsons: sum_1:2:n-2 {1/3* h* (f1 + 4f2 + f3)}
%                 1/3 h (f1 + 4sum_2:2:n(fi) + 2sum_3:2:n-1(fi) + f_n+1)
%   Trap error: (1/12) (b-a)^3 f"_avg / n^2
%   Simp error: -(f""/180)*(b-a)^5/n^4 
% 
% 
% 
% 
% 
% 
% 
