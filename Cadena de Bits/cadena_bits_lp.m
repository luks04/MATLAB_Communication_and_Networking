clc
clear all % Borrar todas las variables del workspace
close all % Cerrar todas las ventanas abiertas

%---------- INPUT ----------
texto ='hola'; % ';' para no mostrar el resultado
regla_bit_alto = 1; % 5 Voltios

%-------- PREOCESS ---------
ascii = double(texto);
bits = dec2bin(ascii); % Convierte de decimal a bits (binary)
cadena = reshape(bits',1,[]); % Cambia la forma, en este caso de matris a vector único ///// '[]' para que recalcule el tamaño de la matriz

tb = 100; % Time_bit
uno = ones(1,tb); % Crea una matris de unos
cero = zeros(1,tb); % Crea una matris de ceros
frame = [];
frameInv = [];

for n=1:length(cadena)
    if(cadena(n)=='1')
        frame = [frame uno];
        frameInv = [frameInv cero]
    else
        frame = [frame cero];
        frameInv = [frameInv uno]
    end
end

if(regla_bit_alto==1)
    cadenaBits = 5*frame;
else
    cadenaBits = 5*frameInv;
end

%--------- OUTPUT ----------
fprintf('Texto: %s\n', texto) % Comando de C para imprimir
ascii
cadena

figure(1)
subplot(2,1,1),plot(frame) % subplot( cantFilas , cantColumn , posición) // plot(graficar)
xticks(0:tb:length(frame))
axis([0 length(frame) -1 2])% axis([ x1 x2 y1 y2]) % Cambiar tamaño de los ejes en el 'plot()'
grid on % Con cuadrícula
title('Señal Binaria')

subplot(2,1,2),plot(cadenaBits)
xticks(0:tb:length(frame))
axis([0 length(cadenaBits) -1 6])
grid on
title('Cadena de Bits')


