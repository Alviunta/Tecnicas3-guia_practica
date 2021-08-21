% Filtros IIR: Leaky Integrator

clear
clc
close all

%% 1) Generaci�n de una se�al senoidal 

% 1.1) Frecuencia de muestreo
fs = 2000;
% 1.2) Frecuencia fundamental
fn = 100;
% 1.3) Periodo de muestreo
dt = 1/fs;
% 1.4) Periodo de la se�al
T = 1/fn;
% 1.5) Generaci�n del vector tiempo (10 periodos de la se�al)
t = 0:dt:T*10; 
% 1.6) Se�al senoidal
signal = sin(2 * pi * fn * t) ;

fprintf("Se�al senoidal generada: fn = %d Hz     fs = %d Hz\n", fn, fs);
%% 2) Agregado de ruido gaussiano a la se�al senoidal

% 2.1) SNR deseada
SNR = 15;
% 2.2) Agregamos ruido a la se�al
[signal_n, var_n] = my_awgn (signal, SNR);
% 2.3) Verificaci�n del valor de SNR
% SNR = 10 * log10 ( SIGNAL POWER / NOISE POWER )
SNR_test = 10 * log10(var(signal)/var(signal_n-signal));

fprintf("SNR requerida = %d     SNR lograda = %d\n",SNR,SNR_test);
%% 3) Filtrado del tipo leaky integrator

% filter One-dimensional digital filter.
%     Y = filter(B,A,X) filters the data in vector X with the
%     filter described by vectors A and B to create the filtered
%     data Y.  The filter is a "Direct Form II Transposed"
%     implementation of the standard difference equation:
%  
%     a(1)*y(n) = b(1)*x(n) + b(2)*x(n-1) + ... + b(nb+1)*x(n-nb)
%                           - a(2)*y(n-1) - ... - a(na+1)*y(n-na)

%%FILTRO LI: y[n] = lambda * y[n-1] + (1-lambda) x[n] :

% 3.1) Valor del coeficiente lambda
lambda=0.5;
% 3.2) Funci�n de transferencia del filtro
a = [1, -lambda]; % Denominador
b = 1-lambda ; % Numerador
% 3.3) Filtrado de la se�al
signal_li = filter(b, a, signal_n);

fprintf("Valor de lambda utilizado = %d\n",lambda);
%% 4) Caracter�stica en frecuencia del filtro LI

% freqz: Frequency response of digital filter
% [H,W] = freqz(B,A,N) returns the N-point complex frequency response
% vector H and the N-point frequency vector W in radians/sample of
% the filter 

% 4.1) Frecuencia de corte del filtro LI
fco=-[log(lambda)*fs]/pi;
% 4.2) Gr�fico de la caracter�stica en frecuencia del filtro LI
figure
freqz( b, a ),title('Caracter�stica en frecuencia filtro LI')

fprintf("Frecuencia de corte del filtro LI = %d\n",fco);
%% 5) Caracter�stica en el dominio Z del filtro LI

figure
zplane(b,a),title('Caracter�stica en el plano Z filtro LI')

%% 6) Grafico de las se�ales en el dominio del tiempo sin ruido, con ruido y filtrada

figure

plot(t, signal, 'b')
hold on
plot(t, signal_n, 'r')
plot(t, signal_li, '-g')
hold off

grid on
title('Respuesta en el tiempo filtro LI')
legend('Se�al original', 'Se�al con ruido', 'Se�al filtrada')

%% 7) Grafico de las se�ales en el dominio de la frecuencia sin ruido, con ruido y filtrada

[frq, mag] = my_dft(signal, fs);
[frq_n, mag_n] = my_dft(signal_n, fs);
[frq_ma, mag_ma] = my_dft(signal_li, fs);

figure

plot(frq, mag, '-b')
hold on
plot(frq_n, mag_n, '-r')
plot(frq_ma, mag_ma, '-g')
hold off

grid on
title('Respuesta en la frecuencia filtro LI')
legend('Se�al original', 'Se�al con ruido', 'Se�al filtrada')