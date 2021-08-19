NAT (Network Address Translation - Traducción de Dirección de Red) 
NAT se encarga de la traducción de direcciones de Red. Su función básica es traducir las IPs privadas de una red local en una IP pública, posibilitando el envío de paquetes a Internet y del mismo modo traducir luego esa IP pública, de nuevo a la IP privada del equipo que envió el paquete, para que pueda recibirlo una vez que llega la respuesta.
NAT se ubica entre las capas de red y de transporte del modelo OSI.

Siempre que un paquete saliente entra en una "caja" NAT, la dirección IP privada de origen se reemplaza por una dirección IP publica. Además, se toma el valor del campo puerto de origen TCP o UDP y se copia en una tabla de traducción.
Cada entrada de la tabla contiene el puerto de origen (TCP o UDP) y la dirección IP privada originales. Finalmente, las sumas de verificación de los encabezados IP y TCP o UDP se recalculan e insertan en el paquete.
Cuando un paquete llega a la caja NAT desde afuera, se extrae el campo "puerto de origen" en el encabezado TCP o UDP y se utiliza como un índice en la tabla de traducción. Con esta entrada se localiza la dirección IP privada interna y el puerto de origen (TCP o UDP) y se insertan en el paquete.

NAT ESTÁTICO
Una de las dos formas de funcionamiento destacado de NAT es la estática.
Conocida también como NAT 1:1, es un tipo de NAT en el que una dirección IP privada se traduce a una dirección IP pública (siempre la misma).

Router > Enable
Router # configure terminal
Router # ip nat inside source static <IP_LOCAL> <IP_EXTERNA>	//ip nat inside source static 192.168.0.2 6.6.6.6

Router # interface <INTERFAZ>			//interface fastethernet0/0
Router # ip nat inside				//Se indica que esta es la interfaz interna
Router # exit

Router # interface <INTERFAZ>			//interface fastethernet1/0
Router # ip nat outside			//Se indica que esta es la interfaz externa
Router # exit


NAT DINÁMICO
La segunda forma de funcionamiento destacado de NAT es la dinámica.
Es un tipo de NAT en la que una dirección IP privada se mapea a una IP pública basándose en una tabla de direcciones de IP registradas (públicas). 


Router > Enable
Router # configure terminal
/*CONTIENE LAS DIRECCIONES IP PUBLICAS*/
Router # ip nat pool <NOMBRE_DE_LISTA_DE_IPS> <PRIMERA_IP> <ULTIMA_IP> netmask <MASCARA_DE_RED>	//ip nat pool listaNat 194.194.194.1 194.194.194.2 netmask 255.255.255.252 

/*RANGO DE DIRECCIONES IP PRIVADAS*/
Router # access-list <NUMERO_DE_LISTA_DE_ACCESO> permit <IP_DE_RED> <WILDCARD>				//access-list 1 permit 192.168.0.0 0.0.0.255 
													
Router # ip nat inside source list <NUMERO_DE_LISTA_DE_ACCESO> pool <NOMBRE_DE_LISTA_DE_IPS> overload	//ip nat inside source list 1 pool listaNat overload

Router # interface <INTERFAZ>			//interface fastethernet0/0
Router # ip nat inside				//Se indica que esta es la interfaz interna
Router # exit

Router # interface <INTERFAZ>			//interface fastethernet1/0
Router # ip nat outside			//Se indica que esta es la interfaz externa
Router # exit

PARA MOSTRAR LA CONFIGURACION:

show ipnat statistics


