% Filtros FIR: Moving Average

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
%% 3) Cálculo del valor máximo del orden del filtro (N_max).

% 3.1) Definición de la frecuencia de corte deseada
fco = fn * 2;
% 3.2) Cálculo de N_Máx
N_max = round(sqrt((((0.885894*fs)^2)/(fco^2))-1));
% 3.3) Valor de N a utilizar en el filtro
N=N_max;
%N=round(N_max/2)
%N=N_max*10
% 3.4) Ventana de tiempo del filtro
N_window_time = N * dt;

fprintf("Frec de corte = %d Hz     N_max = %d     Valor de N a utilizar = %d     Ventana de tiempo = %d segundos\n",fco,N_max,N,N_window_time);
%% 4) Filtrado del tipo moving average

% filter One-dimensional digital filter.
%     Y = filter(B,A,X) filters the data in vector X with the
%     filter described by vectors A and B to create the filtered
%     data Y.  The filter is a "Direct Form II Transposed"
%     implementation of the standard difference equation:
%  
%     a(1)*y(n) = b(1)*x(n) + b(2)*x(n-1) + ... + b(nb+1)*x(n-nb)
%                           - a(2)*y(n-1) - ... - a(na+1)*y(n-na)

% 4.1) Generación de los coeficientes del filtro
a = 1; % Denominador
b = ones(1, N) / N; % Numerador (Coeficientes de FIR MA)
% 4.2) Filtrado de la señal
signal_ma = filter(b, a, signal_n);

%% 5) Característica en frecuencia del filtro MA

% freqz: Frequency response of digital filter
% [H,W] = freqz(B,A,N) returns the N-point complex frequency response
% vector H and the N-point frequency vector W in radians/sample of
% the filter 

figure
freqz( b, a ),title('Característica en frecuencia filtro MA')

%% 6) Grafico de las señales en el dominio del tiempo sin ruido, con ruido y filtrada

figure

plot(t, signal, 'b')
hold on
plot(t, signal_n, 'r')
plot(t, signal_ma, '-g')
hold off

grid on
title('Respuesta en el tiempo filtro MA')
legend('Señal original', 'Señal con ruido', 'Señal filtrada')

%% 7) Grafico de las señales en el dominio de la frecuencia sin ruido, con ruido y filtrada

[frq, mag] = my_dft(signal, fs);
[frq_n, mag_n] = my_dft(signal_n, fs);
[frq_ma, mag_ma] = my_dft(signal_ma, fs);

figure

plot(frq, mag, '-b')
hold on
plot(frq_n, mag_n, '-r')
plot(frq_ma, mag_ma, '-g')
hold off

grid on
title('Respuesta en la frecuencia filtro MA')
legend('Señal original', 'Señal con ruido', 'Señal filtrada')