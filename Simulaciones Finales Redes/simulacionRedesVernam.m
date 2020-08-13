clc, clear all, close all
%---------- INPUT ----------
% Data input:
texto_claro ='Hola';
regla_bit_alto = 1;

% Voltios
A_voltios = 10;

% PU_NRZ input:
regla_pu_nrz = 1;

% P_NRZ input:
regla_p_nrz = 1;

% BP_NRZ input:
condicion_inicial = 1;
regla_bp_nrz = 1;

% Regla de modulación ask
regla_ask_transmite_carrier = 1;

% Regla de modulación fsk
regla_fsk_transmite_carrier = 1;

% Regla de modulación psk
regla_psk_transmite_carrier = 1;

% Carrier
Ac = 10; fc = 1000e3; thetac = 0;

%------------------ PROCESS CIFRADO VERNAM -------------------
ascii = double(texto_claro); % Convierte el string en ascii
bits = dec2bin(ascii,8); % Convierte la variable ascii en binario de 8 bits
binario = reshape(bits',1,[]); % Cambia la forma, en este caso de matris a vector único
clave = randi([0,1],1,length(binario)); % Genera la clave con unos y ceros de forma aleatoria
vernam = [];
uno = ones(1,1); % Crea una matriz de unos de tamaño 1x1
cero = zeros(1,1); % Crea una matriz de ceros de tamaño 1x1

for n=1:length(binario)
    j = bin2dec(binario(n)); % Recorre binario y lo convierte de binario a decimal
    i = clave(n); % Recorre k

    % XOR
    if j == i
        vernam = [vernam cero];
    else
        vernam = [vernam uno];
    end
end

%---------------- PROCESS MODULACION DIGITAL Y CODIFICACIÓN -------------------
% Digitalizacion del Criptograma
datos = dec2bin(vernam);
digitalstream = reshape(datos',1,[]);

tb = 100; 
uno = ones(1,tb);
cero = zeros(1,tb);
delta = 10;
frame = [];
frameInv = [];
frameUPolar = [];
frameUPolarInv = [];
framePolar = [];
framePolarInv = [];
frameBipolar = [];
frameBipolarInv = [];

k = condicion_inicial;
for n=1:length(digitalstream)
    if(digitalstream(n)=='0')
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
    cadenaBits = 5*frame;
else
    cadenaBits = 5*frameInv;
end

% Carrier
tc = linspace(0,2*length(digitalstream)/fc,length(cadenaBits));
carrier = Ac*sin(2*pi*fc*tc+thetac);

% Modulación ASK
if(regla_ask_transmite_carrier == 1)
    ask = frame.*carrier;
else
    ask = frameInv.*carrier;
end

% Modulación FSK
if(regla_fsk_transmite_carrier == 1)
    fsk = frame.*carrier+frameInv.*(Ac*sin(2*pi*(fc/2)*tc+thetac));
else
    fsk = frameInv.*carrier+frame.*(Ac*sin(2*pi*(fc/2)*tc+thetac));
end

% Modulación PSK
if(regla_psk_transmite_carrier == 1)
    psk = frame.*carrier+frameInv.*(Ac*-sin(2*pi*(fc)*tc+thetac));
else
    psk = frameInv.*carrier+frame.*(Ac*-sin(2*pi*(fc)*tc+thetac));
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
fprintf('Texto Claro: ');
disp(texto_claro);
fprintf('Clave:       ');
disp(mat2str(clave));
fprintf('Criptograma: ');
disp(mat2str(vernam));
fprintf('Datos: ');
disp(digitalstream);

%--------- OUTPUT CODIFICACIÓN ----------
figure(1)
titulo_1 = cat(2,'DATOS: ', digitalstream);
subplot(5,1,1),plot(cadenaBits)
xticks(0:tb:length(cadenaBits))
axis([0 length(cadenaBits) (-A_voltios-delta) (A_voltios+delta)])
title(titulo_1)
grid on

titulo_2 = cat(2, 'Unipolar Positiva: ', digitalstream);
subplot(5,1,2),plot(up_positiva)
xticks(0:tb:length(cadenaBits))
axis([0 length(cadenaBits) (-A_voltios-delta) (A_voltios+delta)])
title(titulo_2)
grid on

titulo_3 = cat(2, 'Unipolar Negativa: ', digitalstream);
subplot(5,1,3),plot(up_negativa)
xticks(0:tb:length(cadenaBits))
axis([0 length(cadenaBits) (-A_voltios-delta) (A_voltios+delta)])
title(titulo_3)
grid on

titulo_4 = cat(2, 'Polar:', digitalstream);
subplot(5,1,4),plot(polar)
xticks(0:tb:length(cadenaBits))
axis([0 length(cadenaBits) (-A_voltios-delta) (A_voltios+delta)])
title(titulo_4)
grid on

titulo_5 = cat(2, 'Bipolar:', digitalstream);
subplot(5,1,5),plot(bipolar)
xticks(0:tb:length(cadenaBits))
axis([0 length(cadenaBits) (-A_voltios-delta) (A_voltios+delta)])
title(titulo_5)
grid on

%--------- OUTPUT MODULACIÓN DIGITAL ----------
figure(2)
titulo_6 = cat(2,'DATOS: ', digitalstream);
subplot(5,1,1),plot(cadenaBits)
xticks(0:tb:length(cadenaBits))
axis([0 length(carrier) -Ac Ac])
title(titulo_6)
grid on

titulo_7 = cat(2, 'Carrier:', digitalstream);
subplot(5,1,2),plot(carrier)
xticks(0:tb:length(cadenaBits))
axis([0 length(carrier) -Ac Ac])
title(titulo_7)
grid on

titulo_8 = cat(2, 'ASK:', digitalstream);
subplot(5,1,3),plot(ask)
xticks(0:tb:length(cadenaBits))
axis([0 length(cadenaBits) -Ac Ac])
title(titulo_8)
grid on

titulo_9 = cat(2, 'FSK:', digitalstream);
subplot(5,1,4),plot(fsk)
xticks(0:tb:length(cadenaBits))
axis([0 length(cadenaBits) -Ac Ac])
title(titulo_9)
grid on

titulo_10 = cat(2, 'PSK:', digitalstream);
subplot(5,1,5),plot(psk)
xticks(0:tb:length(cadenaBits))
axis([0 length(cadenaBits) -Ac Ac])
title(titulo_10)
grid on