function V = Vandermonde2(x,m)
%Calculates the Vandermonde matrix given the input vals and the order of
%the polynomial fit
    if nargin  == 1 %sets the default m to length(x) -  1 if not specified by user
        m = length(x) - 1;
    end
    %n = numebr of data points
    n = length(x);
    V = ones(n,m + 1); %preallocate vandermonde matrix
    V(:,m) = x(:); %set the second to last col to the values in x
    for k = (m - 1):-1:1
        V(:,k) = x(:).*V(:,k+1); %assign the rest of the cols to the prev col times x
    end
    
end