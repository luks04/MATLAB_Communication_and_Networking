clc, clear all, close all

%---------- INPUT ----------
A = 10;
f = 10e3;
cant_periodos = 10;
comp_frecuencia = 20;

%-------- PREOCESS ---------
t = linspace(0,cant_periodos/f,500);
diente = 0;

for n=1:comp_frecuencia
    diente = diente+((-1)^(n+1))*(1/n)*sin(2*pi*n*f*t);
end

f_diente_sierra = ((2*A)/pi)*diente;

%--------- OUTPUT ----------
figure(1)
subplot(2,1,1)
plot(t,diente), grid on % No tiene en cuenta la amplitud, solo es el resultado de la sumatoria
subplot(2,1,2)
plot(t,f_diente_sierra), grid on, title('Fourier Diente Sierra')
