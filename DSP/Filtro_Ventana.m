% Filtros FIR: Ventana

clear
clc
close all

%% 1) Generación de una señal senoidal 

% 1.1) Frecuencia de muestreo
fs = 48000;
% 1.2) Frecuencia fundamental
fn = 1000;
% 1.3) Periodo de muestreo
dt = 1/fs;
% 1.4) Periodo de la señal
T = 1/fn;
% 1.5) Generación del vector tiempo (20 periodos de la señal)
t = 0:dt:T*20; 
% 1.6) Amplitud de la señal 
A=1;
% 1.7) Señal senoidal
signal= A*sin(2 * pi * fn * t) ;

fprintf("Señal senoidal generada: fn = %d Hz     fs = %d Hz     Amplitud señal senoidal = %d\n", fn, fs, A);
%% 2) Generación de una señal de interferencia 

% 2.1) Frecuencia de interferencia
fi = 100;
% 2.2) Relación amplitud señal/interferencia
porcentaje=0.2;
% 2.3) Señal de interferencia
signal_int = A*porcentaje*sin(2 * pi * fi * t) ;
% 2.4) Señal total
signal_n=signal+signal_int;

fprintf("Señal interferente: fi = %d Hz     Amplitud interferencia = %d\n", fi, A*porcentaje);
%% 3) Diseño del filtro utilizando filter Designer

%Se debe exportar la función en matlab como File > Generate MATLAB Code > Filter Design Function.
%Utilizar la misma frecuencia de muestreo.
%Exportar con el nombre FIR.m

filterDesigner

%% 4) Filtrado del tipo ventaneo

a=1; %Denominador
Hd=FIR; %Hd es la etructura que devuelve filterDesigner que representa al filtro
b=Hd.Numerator; %Extraemos de la estructura los M+1 coeficientes del numerador 

signal_w = filter(b, a, signal_n); %Filtrado de la señal 
%% 5) Característica en frecuencia del filtro MA

% freqz: Frequency response of digital filter
% [H,W] = freqz(B,A,N) returns the N-point complex frequency response
% vector H and the N-point frequency vector W in radians/sample of
% the filter 

figure
freqz( b, a ),title('Característica en frecuencia filtro de ventana')

%% 6) Grafico de las señales en el dominio del tiempo sin ruido, con ruido y filtrada

figure

plot(t, signal, 'b')
hold on
plot(t, signal_n, 'g')
plot(t, signal_w, 'r')
hold off

grid on
title('Respuesta en el tiempo filtro Ventana')
legend('Señal original', 'Señal con ruido', 'Señal filtrada')

%% 7) Grafico de las señales en el dominio de la frecuencia sin ruido, con ruido y filtrada

[frq, mag] = my_dft(signal, fs);
[frq_n, mag_n] = my_dft(signal_n, fs);
[frq_w, mag_w] = my_dft(signal_w, fs);

figure

plot(frq, mag, 'b')
hold on
plot(frq_n, mag_n, 'g')
plot(frq_w, mag_w, 'r')
hold off

grid on
title('Respuesta en la frecuencia filtro Ventana')
legend('Señal original', 'Señal con ruido', 'Señal filtrada')