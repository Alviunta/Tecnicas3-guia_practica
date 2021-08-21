% Filtros IIR: Transformada Bilineal (Filtro pasabanda Chevyshev)

clear
clc
close all

%% DISEÑO
% Se parte de los datos en el dominio digital. Estos deben ser normalizados
% y precombados para llevarlos al dominio analógico. Después se diseña un
% filtro analógico pasabajos normalizado, que después transformamos a
% pasabanda normalizado y por último desnormalizamos para llegar al filtro
% analógico deseado. Por último aplicamos la trasnformada de Tustin (s a z)
% para obtener el filtro digital deseado.

%% 1) Datos de diseño

% 1.1) Frecuencias de corte
fc1 = 300; %Frecuencia de corte inferior
fc2 = 3400; %Frecuencia de corte superior
% 1.2) Orden del filtro y ripple en banda pasante [dB]
ordenDelFiltro = 10;
ripple = 1;
% 1.3) Frecuencia y periodo de muestreo
fs = fc2*4;
Ts = 1/ fs;

fprintf("Filtro IIR Chevyshev pasabanda:\nOrden = %d\nRipple en banda pasante = %d dB\nFrecuencia de corte inferior = %d Hz\nFrecuencia de corte superior = %d Hz\nFrecuencia de muestreo = %d Hz\n\n",ordenDelFiltro,ripple,fc1,fc2,fs);
%% 2) Calculo de las fecuencias de corte digitales normalizadas

wd1 = fc1 * 2 * pi / fs;
wd2 = fc2 * 2 * pi / fs;

fprintf("Frecuencia de corte inferior digital normalizada = %d\nFrecuencia de corte superior digital normalizada = %d\n\n",wd1,wd2);
%% 3) Cálculo de las frecuencias analógicas precombadas
%Obtengo las frecuencias analÃ³gicas precombadas

wa1 = 2/Ts * tan(wd1/2);
wa2 = 2/Ts * tan(wd2/2);

fprintf("Frecuencia de corte inferior analógica precombada = %d rad/s\nFrecuencia de corte superior analógica precombada = %d rad/s\n\n",wa1,wa2);
%% 4) Diseño de filtro analógico 

% 4.1) Diseño de filtro analógico pasabajos normalizado
% Utilizamos la función chablap, la cual nos devuelve ceros, polos y
% ganancia de la función de transferencia del filtro obtenido.
[z,p,k] = cheb1ap(ordenDelFiltro,ripple);       
[bs_lp, as_lp] = zp2tf(z,p,k); %sufijo lp de lowpass

% 4.2) Cálculo de la frecuencia geométrica del filtro pasabanda
Wo = sqrt(wa1*wa2);
fprintf("Frecuencia geométrica del filtro pasabanda = %d rad/s\n",Wo);

% 4.3) Cálculo del ancho de banda del filtro pasabanda
Bw = wa2 - wa1;
fprintf("Ancho de banda del filtro pasabanda = %d rad/s\n",Bw);

% 4.4) Diseño del filtro analógico pasabanda
% Convierte el filtro analógico pasabajos normalizado en un filtro
% pasabanda con determinada frecuencia central y ancho de banda.
[bs_bp,as_bp] = lp2bp(bs_lp,as_lp,Wo,Bw); %sufijo bp de bandpass

%% 5) Gráfico de la característica en frecuencia del filtro analógico

w=linspace(0.01,fs*4,100000); %Generamos vector de frecuencia
figure (1);
freqs(bs_bp,as_bp,w),title('Característica en frecuencia del filtro analógico') %Respuesta en frecuencia

%% 6) Aplicación de la transformada bilineal (método de Tustin): s --> z

sysa = tf(bs_bp,as_bp); %Función de transferencia analógica (s) 
sysd = c2d(sysa,Ts,'tustin'); %Función de transferencia digital (z)

%% 7) Gráfico de la característica en frecuencia del filtro digital

[bd,ad] = tfdata(sysd,'v');
figure (2);
freqz(bd,ad),title('Característica en frecuencia del filtro digital') %Respuesta en frecuencia

%% 8) Característica en el dominio Z del filtro digital

figure
zplane(bd,ad),title('Característica en el plano Z filtro digital')

%% APLICACIÓN
%% 1) Generación de una señal senoidal 

% 1.2) Frecuencia fundamental
fn = 1000;
% 1.4) Periodo de la señal
Tn = 1/fn;
% 1.5) Generación del vector tiempo (20 periodos de la señal)
t = 0:Ts:Tn*20; 
% 1.6) Amplitud de la señal 
A=1;
% 1.7) Señal senoidal
signal= A*sin(2 * pi * fn * t) ;

fprintf("\nSeñal senoidal generada: fn = %d Hz     fs = %d Hz     Amplitud señal senoidal = %d\n", fn, fs, A);
%% 2) Generación de una señal de interferencia 

% 2.1) Frecuencia de interferencia
fi = 50;
% 2.2) Relación amplitud señal/interferencia
porcentaje=0.2;
% 2.3) Señal de interferencia
signal_int = A*porcentaje*sin(2 * pi * fi * t) ;
% 2.4) Señal total
signal_n=signal+signal_int;

fprintf("Señal interferente: fi = %d Hz     Amplitud interferencia = %d\n", fi, A*porcentaje);
%% 3) Filtrado 

signal_w = filter(bd, ad, signal_n); %Filtrado de la señal 

%% 4) Grafico de las señales en el dominio del tiempo sin ruido, con ruido y filtrada

figure

plot(t, signal, 'b')
hold on
plot(t, signal_n, 'g')
plot(t, signal_w, 'r')
hold off

grid on
title('Respuesta en el tiempo filtro Transformada Bilineal')
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
title('Respuesta en la frecuencia filtro Transformada Bilineal')
legend('Señal original', 'Señal con ruido', 'Señal filtrada')

