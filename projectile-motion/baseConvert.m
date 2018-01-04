function [out] = baseConvert(num_10,newBase)

n = 1;
while ((num_10 - (newBase^n)) > 0)
    n = n+1;
end

p = zeros(n+1,1);

residual = num_10;
for i=size(p,1):-1:1
    p(i) = floor( residual/(newBase^(i-1)) );
    residual = residual - p(i)*(newBase^(i-1));
end
p = p(1:end - 1);
out = p(end:-1:1);
out = out';
out = symbolic(out);
end
function[converted] = symbolic(vector)
    converted = [];
    for x = vector
        if(x < 10)
            pl = num2str(x);
        else
            disp(x)
            pl = char(65 + (x - 10));
        end
        converted = [converted,pl];
    end
    
end
