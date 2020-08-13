clc, clear all, close all
%---------- INPUT ----------
A_voltios = 10;
% Data input:
datos = '0011010001110';
regla_bit_alto = 1;

% PU_NRZ input:
regla_pu_nrz = 1;

% P_NRZ input:
regla_p_nrz = 1;

% BP_NRZ input:
condicion_inicial = 1;
regla_bp_nrz = 1;

%-------- PROCESS ---------
delta = 10;
tb = 100; % Time_bit
uno = ones(1,tb); % Crea una matris de unos
cero = zeros(1,tb); % Crea una matris de ceros
frame = [];
frameInv = [];
frameUPolar = [];
frameUPolarInv = [];
framePolar = [];
framePolarInv = [];
frameBipolar = [];
frameBipolarInv = [];

k = condicion_inicial;
for n=1:length(datos)
    if(datos(n)=='0')
        frame = [frame cero];
        frameInv = [frameInv uno];
        frameUPolar = [frameUPolar cero];
        frameUPolarInv = [frameUPolarInv cero];
        framePolar = [framePolar (-1)*uno];
        framePolarInv = [framePolarInv (+1)*uno];
        frameBipolar = [frameBipolar cero];
        frameBipolarInv = [frameBipolarInv k*uno];
    else
        frame = [frame uno];
        frameInv = [frameInv cero];
        frameUPolar = [frameUPolar (+1)*uno];
        frameUPolarInv = [frameUPolarInv (-1)*uno];
        framePolar = [framePolar (+1)*uno];
        framePolarInv = [framePolarInv (-1)*uno];
        k = -1*k;
        frameBipolar = [frameBipolar k*uno];
        frameBipolarInv = [frameBipolarInv cero];
    end
end

% Regla Bit Alto
if(regla_bit_alto==1)
    cadenaBits = frame;
else
    cadenaBits = frameInv;
end

% Regla Unipolar NRZ
if(regla_pu_nrz==1)
    up_positiva = A_voltios*frameUPolar;
    up_negativa = A_voltios*frameUPolarInv;
else
    up_positiva = A_voltios*frameUPolarInv;
    up_negativa = A_voltios*frameUPolar;
end

% Regla Polar NRZ
if(regla_p_nrz==1)
    polar = A_voltios*framePolar;
else
    polar = A_voltios*framePolarInv;
end

% Regla Biolar NRZ
if(regla_bp_nrz==1)
    bipolar = A_voltios*frameBipolar;
else
    bipolar = A_voltios*frameBipolarInv;
end

%--------- OUTPUT ----------
titulo_1 = cat(2, 'DATOS: ', datos);
figure(1)
subplot(5,2,1),plot(cadenaBits)
xticks(0:tb:length(cadenaBits))
axis([0 length(cadenaBits) (-A_voltios-delta) (A_voltios+delta)])
title(titulo_1)
grid on

titulo_2 = cat(2, 'Unipolar Positiva: ', datos);
subplot(5,2,2),plot(up_positiva)
xticks(0:tb:length(up_positiva))
axis([0 length(cadenaBits) (-A_voltios-delta) (A_voltios+delta)])
title(titulo_2)
grid on

titulo_3 = cat(2, 'Unipolar Negativa: ', datos);
subplot(5,2,4),plot(up_negativa)
xticks(0:tb:length(up_negativa))
axis([0 length(cadenaBits) (-A_voltios-delta) (A_voltios+delta)])
title(titulo_3)
grid on

titulo_3 = cat(2, 'Polar:', datos);
subplot(5,2,3),plot(polar)
xticks(0:tb:length(polar))
axis([0 length(cadenaBits) (-A_voltios-delta) (A_voltios+delta)])
title(titulo_3)
grid on

titulo_4 = cat(2, 'Bipolar:', datos);
subplot(5,2,5),plot(bipolar)
xticks(0:tb:length(bipolar))
axis([0 length(cadenaBits) (-A_voltios-delta) (A_voltios+delta)])
title(titulo_4)
grid on