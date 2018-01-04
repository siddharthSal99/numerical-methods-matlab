function evalmycos1
% Evaluate your mycos1 function for x = 1, 2, 5, 20, and 100 using 100 terms in the
% series
%Find value of cosine using the taylor approximation for the values 
%x = 1,5,20,100
f1 = mycos1(1,100);
f3 = mycos1(5,100);
f4 = mycos1(20,100);
f5 = mycos1(100,100);

%find the exact value using the built in cosine function for matlab for
%x = 1,5,20,100
f1_exact = cos(1);
f3_exact = cos(5);
f4_exact = cos(20);
f5_exact = cos(100);

%using the approximated value and real value for cosine, calculate the
%absolute and relative error of the values of the cosine approximation
aerr1 = abs(f1_exact - f1);
rerr1 = abs(aerr1/f1_exact);

aerr3 = abs(f3_exact - f3);
rerr3 = abs(aerr3/f3_exact);

aerr4 = abs(f4_exact - f4);
rerr4 = abs(aerr4/f4_exact);

aerr5 = abs(f5_exact - f5);
rerr5 = abs(aerr5/f5_exact);

%format the output of the argument, real value, approx value, abs error,
%and relative error
fprintf('%10s %10s %15s %15s %15s\n ','x','cos','mycos1','aerr','rerr');
fprintf('%8d %15e %15e %15e %15e\n',1,f1_exact,f1,aerr1,rerr1); % X = 1
fprintf('%9d %15e %15e %15e %15e\n',5,f3_exact,f3,aerr3,rerr3); % X = 5
fprintf('%9d %15e %15e %15e %15e\n',20,f4_exact,f4,aerr4,rerr4);% X = 20
fprintf('%9d %15e %15e %15e %15e\n',100,f5_exact,f5,aerr5,rerr5);% X = 100
end