clc, clear all, close all
%---------- INPUT ----------
texto_claro ='VERNAM';
%-------- PROCESS ---------
ascii = double(texto_claro); % Convierte el string en ascii
bits = dec2bin(ascii,8); % Convierte la variable ascii en binario de 8 bits
binario = reshape(bits',1,[]); % Cambia la forma, en este caso de matris a vector único
k = randi([0,1],1,length(binario)); % Genera la clave con unos y ceros de forma aleatoria
vernam = [];
uno = ones(1,1); % Crea una matriz de unos de tamaño 1x1
cero = zeros(1,1); % Crea una matriz de ceros de tamaño 1x1

for n=1:length(binario)
    j = bin2dec(binario(n)); % Recorre binario y lo convierte de binario a decimal
    i = k(n); % Recorre k

    % XOR
    if j == i
        vernam = [vernam cero];
    else
        vernam = [vernam uno];
    end
end

fprintf('Texto claro: ');
disp(texto_claro);
% fprintf('Ascii: ');
% disp(ascii);
% fprintf('Bits: ');
% disp(bits);
% fprintf('Binario: ');
% disp(binario);
fprintf('k:      ');
disp(mat2str(k));
fprintf('Vernam: ');
disp(mat2str(vernam));