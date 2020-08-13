clc, clear all, close all

%---------- INPUT ----------
f = 10e3;
cant_periodos = 2;
comp_frecuencia = 50;

%-------- PREOCESS ---------
t = linspace(0,cant_periodos/f,500);
f_cuadrada = 0;

for n=1:2:comp_frecuencia*2-1
    f_cuadrada = f_cuadrada+(1/n)*sin(2*pi*n*f*t)
end


% comp1 = (1/1)*sin(2*pi*1*f*t);
% comp2 = (1/3)*sin(2*pi*3*f*t);
% comp3 = (1/5)*sin(2*pi*5*f*t);
% comp4 = (1/7)*sin(2*pi*7*f*t);
% comp5 = (1/9)*sin(2*pi*9*f*t);
% comp6 = (1/11)*sin(2*pi*11*f*t);
% 
% cuadrada1_c = comp1;
% cuadrada2_c = cuadrada1_c+comp2;
% cuadrada3_c = cuadrada2_c+comp3;
% cuadrada4_c = cuadrada3_c+comp4;
% cuadrada5_c = cuadrada4_c+comp5;
% cuadrada6_c = cuadrada5_c+comp6;

%--------- OUTPUT ----------
figure(1)
plot(t,f_cuadrada),grid on, , title('Fourier Cuadrada')

% subplot(3,2,1)
% plot(t,cuadrada1_c),grid on
% subplot(3,2,2)
% plot(t,cuadrada2_c),grid on
% subplot(3,2,3)
% plot(t,cuadrada3_c),grid on
% subplot(3,2,4)
% plot(t,cuadrada4_c),grid on
% subplot(3,2,5)
% plot(t,cuadrada5_c),grid on
% subplot(3,2,6)
% plot(t,cuadrada6_c),grid on

