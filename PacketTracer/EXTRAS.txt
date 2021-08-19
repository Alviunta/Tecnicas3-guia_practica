CONFIGURAR IP POR CONSOLA:

configure terminal
interface <NOMBRE_INTERFACE>	//interface FastEthernet 0/0
ip address <DIR_IP> <MASCARA>	//192.168.0.1 255.255.255.0

ENCENDER UNA INTERFAZ:

configure terminal
interface <NOMBRE_INTERFACE>	//interface FastEthernet 0/0
no shut

CAMBIAR NOMBRE A UN EQUIPO:

configure terminal
hostname <NOMBRE_EQUIPO>	//hostname router_oficinas

VER DATOS:

En general el comando show permite mostrar datos.
Siempre debe ir acompañado de un argumento que indique que datos se desean mostrar, estos argumentos se muestran pulsando ?
Por ej:

show interfaces	//Nos da como resultado información de cada puerto del router.
show ip interface 	//Nos da como resultado datos del protocolo IP configurado.
show running-config 	//Nos da como resultado la configuración activa 

PARA BORRAR CONFIGURACIONES
Todas las configuraciones pueden ser deshechas utilizando el mismo comando con el que se las creo precedido por no
Por ej:

no ip route 192.168.1.0 255.255.255.0 190.4.4.2 //BORRA EL RUTEO ESTATICO PRECONFIGURADO
