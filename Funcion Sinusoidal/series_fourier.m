clc, clear all, close all
%------------ INPUT GENERAL -----------
A = 10;
f = 10e3;
cant_periodos = 5;
comp_frecuencia = 5;
%---------- PROCESS GENERAL ----------
t = linspace(0,cant_periodos/f,500);
%---------- INPUT SINUSOIDAL ----------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% theta = 0 -> Sin(x) %%%%%%%%%%%
%%%%%%% theta = pi/2 -> Cos(x)%%%%%%%%%
%%%%%%% theta = pi -> - Sin(x)%%%%%%%%%
%%%%%%% theta = 3*pi/2 -> - Cos(x)%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta = 0;
%-------- PROCESS SINUSOIDAL ---------
sinusoidal = A*sin(2*pi*f*t+theta);
%-------------------------------------------------------
%-------- PROCESS FOURIER CUADRADA ---------
f_cuadrada = 0;
for n=1:2:comp_frecuencia*2-1
    f_cuadrada = f_cuadrada+(1/n)*sin(2*pi*n*f*t);
end
%-------------------------------------------------------
%-------- PROCESS FOURIER TRIANGULAR ---------
triangular = 0;
omega = 2*pi*f;
for n=1:comp_frecuencia
    triangular = triangular+(cos((2*n-1)*omega*t))/((2*n-1)^2);
end
f_triangular = (A/2)-(4*A/pi^2)*triangular;
%-------------------------------------------------------
%-------- PROCESS DIENTE SIERRA ---------
diente = 0;
for n=1:comp_frecuencia
    diente = diente+((-1)^(n+1))*(1/n)*sin(2*pi*n*f*t);
end
f_diente_sierra = ((2*A)/pi)*diente;
%------------ OUTPUT GENERAL -----------
figure(1)
subplot(2,2,1)
plot(t,sinusoidal),grid on, title('Fourier Sinusoidal')
subplot(2,2,2)
plot(t,f_cuadrada),grid on, title('Fourier Cuadrada')
subplot(2,2,3)
plot(t,f_triangular), grid on, title('Fourier Triangular')
subplot(2,2,4)
plot(t,f_diente_sierra), grid on, title('Fourier Diente Sierra')

