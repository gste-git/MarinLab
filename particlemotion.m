function [u,w,udot,wdot]=particlemotion(t,x,omega,k,h,z,zeta_a,us)
% calculates hdrodynamic linear wave particle motion
% Input info:
% t OR x as [1xn] vector  time or position
% omega scalar (=2*pi*f)
% k scalar (wave number= 2*pi/wavelength)
% h OR z as [1xn] vector, if t,x=1x1, otherwise both scalar, (depth)
% zeta_a scalar (wave amplitude)

u=(omega*zeta_a * cosh(k*(z+h))/sinh(k*h)) .* sin(omega.*t-k.*x)+us;
w=omega*zeta_a*sinh(k*(z+h))/sinh(k*h) .* cos(omega.*t-k.*x);
udot=omega^2*zeta_a*cosh(k*(z+h))/sinh(k*h) .* cos(omega*t-k.*x);
wdot=-omega^2*zeta_a*sinh(k*(z+h))/sinh(k*h) .* sin(omega.*t-k.*x);

% Horisontal hastighet storst/minst ved pi/2
% Vertikal hastighet storst ved t=0; 
% Horisontal acceleration storst/minst ved maks vertikal hastighet ved t=0
% Vertikal acceleration storst ved maks horisontal hastighet ved p/2
% 
% if length(t)>1 || length(x)>1
% figure(100)
% subplot(211)
% plot(t,u,'b-',t,udot,'r--')
% title('Horizontal particle direction')
% legend('Velocity','Acceleration')
% ylabel('u , a_x')
% xlabel('t [s]')
% subplot(212)
% plot(t,w,'b-',t,wdot,'r--')
% title('Vertical particle direction')
% legend('Velocity','Acceleration')
% ylabel('w , a_z')
% xlabel('t [s]')
% end