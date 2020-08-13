clc, clear all, close all

%---------- INPUT ----------
A = 10;
f = 10e3; % 10 kHz -> Ne3 = N*10^3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% theta = 0 -> Sin(x) %%%%%%%%%%%
%%%%%%% theta = pi/2 -> Cos(x)%%%%%%%%%
%%%%%%% theta = pi -> - Sin(x)%%%%%%%%%
%%%%%%% theta = 3*pi/2 -> - Cos(x)%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta = 0;
cant_periodos = 1;

%-------- PREOCESS ---------
t = linspace(0,cant_periodos/f,500);
sinusoidal = A*sin(2*pi*f*t+theta)

% sinusoidal_0 = A*sin(2*pi*f*t+0)
% sinusoidal_90 = A*sin(2*pi*f*t+pi/2)
% sinusoidal_180 = A*sin(2*pi*f*t+pi)
% sinusoidal_270 = A*sin(2*pi*f*t+3*pi/2)

%--------- OUTPUT ----------
figure(1)
plot(t,sinusoidal),grid on

% subplot(2,2,1)
% plot(t,sinusoidal_0),grid on,title('Sin(x)')
% subplot(2,2,2)
% plot(t,sinusoidal_90),grid on,title('Cos(x)')
% subplot(2,2,3)
% plot(t,sinusoidal_180),grid on,title('- Sin(x)')
% subplot(2,2,4)
% plot(t,sinusoidal_270),grid on,title('-Cos(x)')
