DHCP (Protocolo de Configuración Dinámica de Host)
DHCP es un protocolo (tipo cliente – servidor) que permite a los clientes de una red IP obtener sus parámetros de configuración automáticamente. 

DHCP es un protocolo de capa de aplicación modelo OSI

Asignación manual o estática: Asigna una dirección IP a una máquina determinada.
Asignación automática: Asigna una dirección IP de forma permanente a una máquina la primera vez que hace la solicitud al servidor DHCP y hasta que el cliente la libera
Asignación dinámica: el único método que permite la reutilización dinámica de las direcciones IP. El administrador de la red determina un rango de direcciones IP y cada dispositivo conectado a la red está configurado para solicitar su dirección IP al servidor cuando la tarjeta de interfaz de red se inicializa. 

SE DEBE CONFIGURAR A LOS HOSTS PARA RECIBIR LA CONFIGURACION POR DHCP

Router > Enable
Router # configure terminal
Router # ip dhcp excluded-address <IP_inicial> <IP_final> 		//Se identifican las direcciones que no quiero que se asignen
Router # ip dhcp pool <nombre>						//Se configura el nombre de la lista de IPs a asignar
Router # network <IP RED> <MASCARA DE RED>				//Se indican las direcciones de red a asignar a los hosts
Router # default-router <IP_GATEWAY>					//Se indica el gateway que se le dara a los hosts
Router # dns-server <IP servidor DNS>					//Se indica la ip del servidor DNS que se le dara a los hosts



Mostrar tabla de asignacion
show ip dhcp binding
