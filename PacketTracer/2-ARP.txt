//PROTOCOLO ARP

ES UN PROTOCOLO PARA ASOCIAR UNA DIRECCION IP (CONOCIDA) CON UNA DIRECCION MAC

Aunque cada host tiene una (o más) direcciones IP, éstas no pueden usarse para enviar paquetes porque el hardware de capa de enlace de datos no
entiende las direcciones IP. Cada tarjeta Ethernet viene provista de fábrica con una dirección Ethernet de 48 bits (MAC). Los fabricantes de tarjetas Ethernet
solicitan un bloque de direcciones a una autoridad central para asegurar que dos tarjetas no tengan la misma dirección. Las tarjetas envían y reciben tramas
basadas en direcciones Ethernet de 48 bits. No saben nada de direcciones IP de 32 bits.
ARP: Protocolo de resolución de direcciones, es un protocolo responsable de encontrar la dirección hardware (Ethernet MAC) que corresponde a una
determinada dirección IP, es decir resuelve el problema de encontrar qué dirección Ethernet corresponde a una dirección IP dada.
La definición de ARP está en el RFC 826. ARP es un protocolo de capa 2 y 3 del modelo OSI, se ubica entre ambas
capas. 


ARP - Protocolo de Resolución de Direcciones
Funcionamiento:
Se envía un paquete (ARP request) a la DIRECCIÓN DE DIFUSIÓN DE LA RED (broadcast → MAC = FF FF FF FF FF FF) que contiene la dirección IP por la que se pregunta, y se espera a que esa máquina (u otra) responda (ARP reply) con la dirección Ethernet que le corresponde.
Cada máquina mantiene una tabla con las direcciones traducidas para reducir el retardo y la carga.
ARP permite a la dirección de Internet ser independiente de la dirección Ethernet, pero esto sólo funciona si todas las máquinas lo soportan.
Para permitir que las direcciones físicas cambien, por ejemplo, cuando una tarjeta Ethernet falla y se reemplaza con una nueva (nueva dirección Ethernet), las entradas en la tabla ARP deben expirar en unos cuantos minutos.

Para visualizar tabla arp en una PC ponemos (o la lupa)
	arp -a
Para limpiar tabla arp en una PC ponemos 
	arp -d
Para visualizar tabla arp en el router usamos la lupa.
	show ip arp
Para limpiar tabla arp en el router ponemos
	enable
	clear arp
	

RARP -Protocolo de Resolución de Dirección de Retorno
RARP: Este protocolo permite que un host recientemente inicializado transmita
su dirección Ethernet y pregunte por su dirección IP.
El servidor RARP ve esta solicitud, busca la dirección Ethernet en sus archivos
de configuración y devuelve la dirección IP correspondiente.
RARP está definido en el RFC 903
