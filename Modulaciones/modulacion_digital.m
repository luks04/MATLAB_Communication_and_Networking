clc, clear all, close all
%---------- INPUT ----------
datos = '00110100010';
regla_bit_alto = 0;

% Regla de modulación ask
regla_ask_transmite_carrier = 1;

% Regla de modulación fsk
regla_fsk_transmite_carrier = 1;

% Regla de modulación psk
regla_psk_transmite_carrier = 1;

% Carrier
Ac = 10; fc = 1000e3; thetac = 0;

%-------- PROCESS ---------
tb = 100; 
uno = ones(1,tb);
cero = zeros(1,tb);
frame = [];
frameInv = [];

for n=1:length(datos)
    if(datos(n)=='1')
        frame = [frame uno];
        frameInv = [frameInv cero];
    else
        frame = [frame cero];
        frameInv = [frameInv uno];
    end
end

if(regla_bit_alto==1)
    cadenaBits = 5*frame;
else
    cadenaBits = 5*frameInv;
end

% Carrier
tc = linspace(0,2*length(datos)/fc,length(cadenaBits));
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

%--------- OUTPUT ----------
titulo = cat(2, 'DATOS: ', datos);
figure(1)
subplot(5,1,1),plot(cadenaBits)
xticks(0:tb:length(cadenaBits))
axis([0 length(cadenaBits) -1 6])
title(titulo)
grid on

subplot(5,1,2),plot(carrier)
axis([0 length(carrier) -Ac Ac])
title('Carrier')
grid on

subplot(5,1,3),plot(ask)
axis([0 length(cadenaBits) -Ac Ac])
title('ASK')
grid on

subplot(5,1,4),plot(fsk)
axis([0 length(cadenaBits) -Ac Ac])
title('FSK')
grid on

subplot(5,1,5),plot(psk)
axis([0 length(cadenaBits) -Ac Ac])
title('PSK')
grid on
