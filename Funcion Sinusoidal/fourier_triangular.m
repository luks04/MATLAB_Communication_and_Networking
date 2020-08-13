clc, clear all, close all

%---------- INPUT ----------
A = 10;
f = 10e3;
cant_periodos = 10;
comp_frecuencia = 20;

%-------- PREOCESS ---------
t = linspace(0,cant_periodos/f,500);
triangular = 0;
omega = 2*pi*f;

% for n=1:2:(comp_frecuencia*2-1)
%     triangular = triangular+(cos(n*omega*t))/(n^2);
% end

for n=1:comp_frecuencia
    triangular = triangular+(cos((2*n-1)*omega*t))/((2*n-1)^2);
end

f_triangular = (A/2)-(4*A/pi^2)*triangular;

%--------- OUTPUT ----------
figure(1)
subplot(2,1,1)
plot(t,triangular), grid on % No tiene en cuenta la amplitud, solo es el resultado de la sumatoria
subplot(2,1,2)
plot(t,f_triangular), grid on, title('Fourier Triangular')
