function plotmycos1
%Usage: plotmycos1()
%this function evaluates and plots the values of cosine, and the respective absolute
%error for X = 1,5,20,100. The number of terms is 100
nterms = 1:100;
%initalize the vectors that store the intermdiate values for cos(1),
%cos(5), cos(20), cos(100)
cosvals1 = [];
aerr1 = [];
cosvals3 = [];
aerr3 = [];
cosvals4 = [];
aerr4 = [];
cosvals5 = [];
aerr5 = [];
% Run the calculation for 100 terms, storing the intermediate sum for each value
% of X, ie 1,5,20,100
for k = nterms
    val = mycos1(1,k);
    cosvals1 = [cosvals1, val];
    cos1 = cos(1);
    aerr1 = [aerr1, abs(cos1 - val)];

    val3 = mycos1(5,k);
    cosvals3 = [cosvals3, val3];
    cos3 = cos(5);
    aerr3 = [aerr3, abs(cos3 - val3)];

    val4 = mycos1(20,k);
    cosvals4 = [cosvals4, val4];
    cos4 = cos(20);
    aerr4 = [aerr4, abs(cos4 - val4)];

    val5 = mycos1(100,k);
    cosvals5 = [cosvals5, val5];
    cos5 = cos(100);
    aerr5 = [aerr5, abs(cos5 - val5)];
end
%using the helper function plotCos below, the figures are plotted with two
%graphs comparing the intermediate sum value of cosine and the absolute
%error with respect to the number of terms
plotCos(nterms,cosvals1,1, aerr1);
plotCos(nterms,cosvals3,5, aerr3);
plotCos(nterms,cosvals4,20, aerr4);
plotCos(nterms,cosvals5,100, aerr5);


end

function plotCos(nterms,cosvals,X, aerr)
% Usage: function plotCos(nterms,cosvals,X,aerr)
%given the number of terms, the intermediate sum of cosine, the argument
%value, and the absolute error, this function plots the figure of two
%subplots that compare the values of cosine, the absolute error to the
%number of terms.
figure
% create figure and subplot
subplot(2,1,1);
plot(nterms,cosvals);
%label the title
str = sprintf('Convergence diagram for x = %d', X);
title(str);
ylabel('value for finite series');
%move to next subplot
subplot(2,1,2);
plot(nterms,aerr);
ylabel('error for finite series');
xlabel('number of terms');
end