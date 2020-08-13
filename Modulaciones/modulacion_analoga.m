clc, clear all, close all
%---------- INPUT ----------
% xt
Ax = 2; fx = 3400; thetax = 0; cpx = 2;

% Carrier
Ac = 10; fc = 1000e3; thetac = 0; cpc = 16;

% Índice de modulación AM
m = 0.4; % m enntre 0 y 1

% Índice de modulación FM
nfm = 2; % nfm mayor o igual a 2

% Índice de modulación PM
npm = 2; % npm mayor o igual a 2

%-------- PROCESS ---------
% Carrier
tc = linspace(0,cpc/fc,500);
carrier = Ac*sin(2*pi*fc*tc+thetac);

% xt
tx = linspace(0,cpx/fx,500);
xt = Ax*sin(2*pi*fx*tx+thetax);

% Modulación AM
xam = (1+m*xt).*carrier; % Multiplicación punto a punto ".*"
% Modulación FM
xfm = Ac*sin(2*pi*fc*tc+nfm*xt);
% Modulación PM
xt_diff = Ax*sin(2*pi*fx*tx+(thetax+pi/2));
xpm = Ac*sin(2*pi*fc*tc+npm*xt_diff);

%--------- OUTPUT ----------
figure(1)
subplot(5,1,1), plot(tx,xt), title('Datos Análogos x(t)')
subplot(5,1,2), plot(tc,carrier), title('Señal portadora carrier')
subplot(5,1,3), plot(tc,xam), title('Señal AM')
subplot(5,1,4), plot(tc,xfm), title('Señal FM')
subplot(5,1,5), plot(tc,xpm), title('Señal PM')