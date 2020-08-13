clc, clear all, close all
%---------- INPUT ----------
f = 10e3;
cant_periodos = 2;
comp_frecuencia = 5;
%-------- PROCESS ----------
t = linspace(0,cant_periodos/f,500);
f_transformada = 0;
f_cuadrada = 0;

for n=1:2:comp_frecuencia*2-1
    f_transformada = f_transformada+abs(fftshift(fft((1/n)*sin(2*pi*n*f*t))));
    f_cuadrada = f_cuadrada+(1/n)*sin(2*pi*n*f*t);
end
% 'abs' es valor absoluto
% 'fft' aplica la transformada rápida de fourier
%--------- OUTPUT ----------
figure(1)
subplot(3,2,1)
plot(t,f_cuadrada),grid on, title('Señal en el Dominio del Tiempo')
subplot(3,2,2)
plot(f_transformada),grid on, title('Espectro Completo (-\infty;\infty)')
subplot(3,2,3)
plot(f_transformada(250:300)),grid on, title('Espectro Positivo')
