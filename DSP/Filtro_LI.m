% Filtros IIR: Leaky Integrator

clear
clc
close all

%% 1) Generación de una señal senoidal 

% 1.1) Frecuencia de muestreo
fs = 2000;
% 1.2) Frecuencia fundamental
fn = 100;
% 1.3) Periodo de muestreo
dt = 1/fs;
% 1.4) Periodo de la señal
T = 1/fn;
% 1.5) Generación del vector tiempo (10 periodos de la señal)
t = 0:dt:T*10; 
% 1.6) Señal senoidal
signal = sin(2 * pi * fn * t) ;

fprintf("Señal senoidal generada: fn = %d Hz     fs = %d Hz\n", fn, fs);
%% 2) Agregado de ruido gaussiano a la señal senoidal

% 2.1) SNR deseada
SNR = 15;
% 2.2) Agregamos ruido a la señal
[signal_n, var_n] = my_awgn (signal, SNR);
% 2.3) Verificación del valor de SNR
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
% 3.2) Función de transferencia del filtro
a = [1, -lambda]; % Denominador
b = 1-lambda ; % Numerador
% 3.3) Filtrado de la señal
signal_li = filter(b, a, signal_n);

fprintf("Valor de lambda utilizado = %d\n",lambda);
%% 4) Característica en frecuencia del filtro LI

% freqz: Frequency response of digital filter
% [H,W] = freqz(B,A,N) returns the N-point complex frequency response
% vector H and the N-point frequency vector W in radians/sample of
% the filter 

% 4.1) Frecuencia de corte del filtro LI
fco=-[log(lambda)*fs]/pi;
% 4.2) Gráfico de la característica en frecuencia del filtro LI
figure
freqz( b, a ),title('Característica en frecuencia filtro LI')

fprintf("Frecuencia de corte del filtro LI = %d\n",fco);
%% 5) Característica en el dominio Z del filtro LI

figure
zplane(b,a),title('Característica en el plano Z filtro LI')

%% 6) Grafico de las señales en el dominio del tiempo sin ruido, con ruido y filtrada

figure

plot(t, signal, 'b')
hold on
plot(t, signal_n, 'r')
plot(t, signal_li, '-g')
hold off

grid on
title('Respuesta en el tiempo filtro LI')
legend('Señal original', 'Señal con ruido', 'Señal filtrada')

%% 7) Grafico de las señales en el dominio de la frecuencia sin ruido, con ruido y filtrada

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
legend('Señal original', 'Señal con ruido', 'Señal filtrada')