function [ev,yfit] = decay_fit(t, y)
% Fits damped oscillative curve to experimental decay test
% INPUT:
% t : time vector of data to be fitted
% y : motion data to be fitted
% OUTPUT
% ev : eigen value = damping +/- omega i  (omega=2*pi*freq)

  % guess for frequency and damping
  f0=1;   % frequency [Hz], set it approximately to what you see in the experiment
  x(1) = f0*2*pi; % frequency [rad]
  x(2) = 0;  % dempning
  x(3) = 0;    % fas
  x(4) = max(abs(y));
  x(5) = 0;
  x = lsqcurvefit(@expsin, x, t, y);
  
  yfit=expsin(x, t);
  ev = x(2) + i*x(1);
  fprintf(1,' \n ---- Decay test ----')
  fprintf(1, '\n Period: %.3f s \n Frequency: %.3f Hz \n Damping: %.3f\n\n', (2*pi)/x(1), x(1)/(2*pi), x(2));
  
  % compare data with results, or plot(t, yfit) outside
  %figure(100)
  %plot(t, y, 'b-', t, yfit, 'r--');
  %legend('Experiment','Curve fit')
  
  function y = expsin(x, td)
    y = x(4) * exp(x(2)*td) .* sin(x(1)*td + x(3)) + x(5);
  end
    
end
