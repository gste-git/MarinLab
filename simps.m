function [A]=simps(x,y)

% Finds the area under a curve y(x) using Simpson's 2nd rule.
% x must have same step spacing and uneven length

n=length(x);
if mod(n,2)==0
    disp('The length of vector x must be odd.')
    return
elseif n==1
    disp('The length of vector x must be at least 3.')
    return
end


for i=1:2:n-2
    s42(i)=4;
    for j=2:2:n-2
        s42(j)=2;
    end
end

simf=[1 s42 4 1]; % Simpson factor vector

s=x(2)-x(1);

A=s/3 *  (simf*y');