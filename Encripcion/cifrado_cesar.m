clc, clear all, close all
%---------- INPUT ----------
texto_claro ='HOLA XYZ hola niño xyz';
%-------- PROCESS ---------

alfabeto = ['A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'Ñ' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' 'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'ñ' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'];

cesar = '';
Tk = 3;
k = '';
i = 0;

for n=1:length(texto_claro)
    k = texto_claro(n); % Recorre texto_claro
    
    switch k
        case 'X'
            i = -2;
        case 'Y'
            i = -1;
        case 'Z'
            i = 0;
        case 'x'
            i = 25;
        case 'y'
            i = 26;
        case 'z'
            i = 27;
        otherwise
            i = find(alfabeto == k); % Encuentra el índice de k
    end
    
    if(k == ' ')
        cesar = cat(2,cesar,' ');
    else
        cesar = cat(2,cesar,alfabeto(i+Tk));
    end
end

%--------- OUTPUT ----------
fprintf('Texto Claro: ');
disp(texto_claro);
fprintf('Criptograma: ');
disp(cesar);