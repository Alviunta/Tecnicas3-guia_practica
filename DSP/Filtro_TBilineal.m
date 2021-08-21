% Filtros IIR: Transformada Bilineal (Filtro pasabanda Chevyshev)

clear
clc
close all

%% DISE�O
% Se parte de los datos en el dominio digital. Estos deben ser normalizados
% y precombados para llevarlos al dominio anal�gico. Despu�s se dise�a un
% filtro anal�gico pasabajos normalizado, que despu�s transformamos a
% pasabanda normalizado y por �ltimo desnormalizamos para llegar al filtro
% anal�gico deseado. Por �ltimo aplicamos la trasnformada de Tustin (s a z)
% para obtener el filtro digital deseado.

%% 1) Datos de dise�o

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
%% 3) C�lculo de las frecuencias anal�gicas precombadas
%Obtengo las frecuencias analógicas precombadas

wa1 = 2/Ts * tan(wd1/2);
wa2 = 2/Ts * tan(wd2/2);

fprintf("Frecuencia de corte inferior anal�gica precombada = %d rad/s\nFrecuencia de corte superior anal�gica precombada = %d rad/s\n\n",wa1,wa2);
%% 4) Dise�o de filtro anal�gico 

% 4.1) Dise�o de filtro anal�gico pasabajos normalizado
% Utilizamos la funci�n chablap, la cual nos devuelve ceros, polos y
% ganancia de la funci�n de transferencia del filtro obtenido.
[z,p,k] = cheb1ap(ordenDelFiltro,ripple);       
[bs_lp, as_lp] = zp2tf(z,p,k); %sufijo lp de lowpass

% 4.2) C�lculo de la frecuencia geom�trica del filtro pasabanda
Wo = sqrt(wa1*wa2);
fprintf("Frecuencia geom�trica del filtro pasabanda = %d rad/s\n",Wo);

% 4.3) C�lculo del ancho de banda del filtro pasabanda
Bw = wa2 - wa1;
fprintf("Ancho de banda del filtro pasabanda = %d rad/s\n",Bw);

% 4.4) Dise�o del filtro anal�gico pasabanda
% Convierte el filtro anal�gico pasabajos normalizado en un filtro
% pasabanda con determinada frecuencia central y ancho de banda.
[bs_bp,as_bp] = lp2bp(bs_lp,as_lp,Wo,Bw); %sufijo bp de bandpass

%% 5) Gr�fico de la caracter�stica en frecuencia del filtro anal�gico

w=linspace(0.01,fs*4,100000); %Generamos vector de frecuencia
figure (1);
freqs(bs_bp,as_bp,w),title('Caracter�stica en frecuencia del filtro anal�gico') %Respuesta en frecuencia

%% 6) Aplicaci�n de la transformada bilineal (m�todo de Tustin): s --> z

sysa = tf(bs_bp,as_bp); %Funci�n de transferencia anal�gica (s) 
sysd = c2d(sysa,Ts,'tustin'); %Funci�n de transferencia digital (z)

%% 7) Gr�fico de la caracter�stica en frecuencia del filtro digital

[bd,ad] = tfdata(sysd,'v');
figure (2);
freqz(bd,ad),title('Caracter�stica en frecuencia del filtro digital') %Respuesta en frecuencia

%% 8) Caracter�stica en el dominio Z del filtro digital

figure
zplane(bd,ad),title('Caracter�stica en el plano Z filtro digital')

%% APLICACI�N
%% 1) Generaci�n de una se�al senoidal 

% 1.2) Frecuencia fundamental
fn = 1000;
% 1.4) Periodo de la se�al
Tn = 1/fn;
% 1.5) Generaci�n del vector tiempo (20 periodos de la se�al)
t = 0:Ts:Tn*20; 
% 1.6) Amplitud de la se�al 
A=1;
% 1.7) Se�al senoidal
signal= A*sin(2 * pi * fn * t) ;

fprintf("\nSe�al senoidal generada: fn = %d Hz     fs = %d Hz     Amplitud se�al senoidal = %d\n", fn, fs, A);
%% 2) Generaci�n de una se�al de interferencia 

% 2.1) Frecuencia de interferencia
fi = 50;
% 2.2) Relaci�n amplitud se�al/interferencia
porcentaje=0.2;
% 2.3) Se�al de interferencia
signal_int = A*porcentaje*sin(2 * pi * fi * t) ;
% 2.4) Se�al total
signal_n=signal+signal_int;

fprintf("Se�al interferente: fi = %d Hz     Amplitud interferencia = %d\n", fi, A*porcentaje);
%% 3) Filtrado 

signal_w = filter(bd, ad, signal_n); %Filtrado de la se�al 

%% 4) Grafico de las se�ales en el dominio del tiempo sin ruido, con ruido y filtrada

figure

plot(t, signal, 'b')
hold on
plot(t, signal_n, 'g')
plot(t, signal_w, 'r')
hold off

grid on
title('Respuesta en el tiempo filtro Transformada Bilineal')
legend('Se�al original', 'Se�al con ruido', 'Se�al filtrada')

%% 7) Grafico de las se�ales en el dominio de la frecuencia sin ruido, con ruido y filtrada

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
legend('Se�al original', 'Se�al con ruido', 'Se�al filtrada')

