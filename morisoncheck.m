function [lambda_D,H_D]=morisoncheck(lambda,H,D)
% Input lambda - wave length [m]
%       H - Wave height, valley to top [m]
%       D - Lengt of object in x dir [m]
% Output lambda_D =lambda/D ratio for morisoncheck
%        H_D = H/D          ratio for morison check

lambda_D=lambda./D;
H_D=H./D;

if H>lambda./7
    disp('Warning: Wave cresting !')
 end


if lambda./D>5 % Morisonanvendelse
    fprintf(1,'Morison can be used, lambda/D = %.3f > 5\n', lambda./D)
else
    fprintf(1,'Morison can not be used, wave diffraction: lambda/D = %.3f < 5\n', lambda./D)
end

if H./D>4*pi
    fprintf(1,'Viscous forces dominate, H/D = %.3f > 4*pi \n',H./D)
else
    fprintf(1,'Mass forces dominate, H/D = %.3f < 4*pi \n',H./D)
end
