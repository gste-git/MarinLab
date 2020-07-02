function Re=Re_cal(V,l,N)
% INPUT:
% V: velocity
% l: length of obejct in flow (i.e, chord, diameter)
% N: Choose case 1 (fresh water), 2 (sea water) or 3 (air) - all at 15 deg
% OUTPUT
% Re: Reynolds number

% Flow physics
% rho: [kg/m^3] density
% ny : [m^2/s]=[stoke] kinematic viscosity (mu/rho) 
% mu : [Pa s]=[N/m^2-s]=[kg/m-s] dynamic viscosity 1cPoise =10^-3  

if N==1 % MarinLab
rho = 999.1026;  %fresh water 15 deg ITTC 7.5-02-01-03
ny =1.1386e-06; % fresh water 15 deg ITTC 7.5-02-01-03
mu =ny*rho; 
fprintf('-----------------------')
fprintf(1,'\nFresh water: 15 deg ITTC\n')
elseif N==2 % Sea water
rho = 1026.021;  % sea water 15 deg ITTC 7.5-02-01-03
ny =1.1892e-06; % sea water 15 deg ITTC 7.5-02-01-03
mu =ny*rho; 
fprintf('-----------------------')
fprintf(1,'\nSea water: 15 deg ITTC\n')
elseif N==3 % Air STD atm
rho=1.225;        % density of air at standard atmospehere, 15 deg
ny= 1.470e-05;
mu =ny*rho;
fprintf('-----------------------')
fprintf(1,'\nAir: 15 deg STD\n')
else
    fprintf(1,'\n!Choose a case number: 1 (fresh water), 2 (sea water) or 3 (air). \n')
    Re=NaN;
end

if N==1 || N==2 || N==3 
Re=(V.*l)./ny;
end

fprintf(1,'Re = %4e \n',Re)
fprintf('-----------------------\n\n')


