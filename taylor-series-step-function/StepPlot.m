function StepPlot
%creates plots for the step function for varying values for the number of
%terms
x = linspace(-1,1,1001); %row vector of approximated x values
f1 = stepFunction2(x,5); %5 terms
f2 = stepFunction2(x,20);% 20 terms
f3 = stepFunction2(x,50);% 50 terms


figure;
subplot(3,1,1);
plot(x,f1);
nterms = sprintf('number of terms: %d',5);
title(nterms);
xlabel('x');
ylabel('f(x)');

subplot(3,1,2);
plot(x,f2);
nterms2 = sprintf('number of terms: %d',20);
title(nterms2);
xlabel('x');
ylabel('f(x)');

subplot(3,1,3);
plot(x,f3);
nterms3 = sprintf('number of terms: %d',50);
title(nterms3);
xlabel('x');
ylabel('f(x)');
fprintf('%10s %10s %10s\n','nterms','max','xloc');
x1_max = find(f1 == max(f1)); %find the max value of each of these points
x2_max = find(f2 == max(f2));
x3_max = find(f3 == max(f3));
fprintf('%10d %10.4f      %10e\n',5,max(f1),x(x1_max(1)));
fprintf('%10d %10.4f      %10e\n',20,max(f2),x(x2_max(1)));
fprintf('%10d %10.4f      %10e\n',50,max(f3),x(x3_max(1)));


end