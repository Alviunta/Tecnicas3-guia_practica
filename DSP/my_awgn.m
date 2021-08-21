function [signal_n, var_n] = my_awgn (signal, snr);
%Calculamos la varianza de signal (señal) y la del ruido (r) 
var_s = var(signal);
var_n = (var_s)/(10^(snr/10));


%Calculamos la desviacion estandar del ruido para ajustar la desviacion
%estandar que trae por defecto la funcion rands que es 1.
dev_n = sqrt(var_n);


%generamos el ruido con la funcion randn que tiene que tener el mismo
%tamaño que s y siempre la media es igual a cero
ruido = dev_n*randn(size(signal));

%Ahora le sumamos el ruido generado a mi funcion s
signal_n = ruido + signal;
end