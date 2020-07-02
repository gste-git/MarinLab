function [lambda,depthratio,wavenumber]=lambda_cal(T,h,H)
% Calculates wave length using linear wave theory
% T: wave period (s)
% h: water depth (m)
% H: wave height (m) (double amplitude)
% output
% lambda: wave length (m)
% depthratio h/lambda (-)
% wavenumber k=2pi/lambda (rad/m)

% if depth too small for wave height to fit
if H>1.9*h
    disp('Warning: Wave height to large for depth H>1.9*h!!!')
    lambda=NaN;    depthratio=NaN;    wavenumber=NaN;
    return
end

g=9.81;

% Manual version, how you do it by hand:
lambda=g/2/pi*T^2;    % start value for iteration
lam0=1;
iter=0;
while lam0>0.001   
    lambdanew=g/2/pi*T^2*tanh(2*pi*h/lambda);
    lam0=abs(lambda-g/2/pi*T^2*tanh(2*pi*h/lambdanew));
    lambda=lambdanew;
    iter=iter+1;
end
iter=iter;

%f=@(lambda)g/2/pi*T^2*tanh(2*pi*h/lambda)-lambda;
%lambda=fzero(f,50);


depthratio=h/lambda;
wavenumber=2*pi/lambda;

% Vanndyp check
if h/lambda<0.05
    fprintf(1,'Grunt vann: lambda= %0.2f m, h/lambda= %0.2f, k=%0.2f rad/m \n', lambda, h/lambda, wavenumber)
    disp('Use other methods to calculate u,w,au,aw')
     if H>0.88*h
      disp('Warning: Wave cresting: H>0.88*h !')
     end
elseif h/lambda>=0.05 && h/lambda<=0.5
    fprintf(1,'Endelig vanndyp: lambda= %0.2f m, h/lambda= %0.2f, k=%0.2f rad/m \n', lambda, h/lambda, wavenumber)
     if H>lambda./7
      disp('Warning: Wave cresting: H>lambda/7 !')
     end
elseif h/lambda>0.5
     fprintf(1,'Dypt vann: lambda= %0.2f m, h/lambda= %0.2f, k=%0.2f rad/m \n', lambda, h/lambda, wavenumber)
     if H>lambda./7
      disp('Warning: Wave cresting: H>lambda/7 !')
     end
else
    disp('Error')
end
