ESTE PRACTICO ES MAS VER QUE LA TEORIA NO ES UNA JODA Y QUE SE CUMPLEN LAS CABECERAS Y PROCEDIMIENTOS DE LOS PROTOCOLOS, NO HAY MUCHA PRACTICA

UDP (UserDatagramProtocol): Protocolo de capa de transporte no-orientado a la conexión (PDU=datagramas)

UDP no tiene confirmación de entrega, ni control de flujo, por lo que no son funciones de la capa de transporte.
UDP sólo añade multiplexado de aplicación y suma de verificación de la cabecera y la carga útil. Cualquier tipo de garantías para la transmisión de la información deben ser implementadas en capas superiores.
Lo utilizan aplicaciones como:
• NFS (Network File System)
• RCP: comando para copiar ficheros remotos
• BOOTP (Bootstrap Protocol)
• TFTP:(Trivial file transfer Protocol) Protocolo de transferencia de archivos trivial
• SNMP: (Simple Network Management Protocol) Protocolo Simple de Administración de Red
• DHCP: (Dynamic Host Configuration Protocol) protocolo de configuración dinámica de host
• DNS: (Domain Name System o DNS) sistema de nombres de dominio
• La tecnología VoIP: (Voz sobre Protocolo de Internet) lo utiliza como protocolo de transporte 

	Se usa como ejemplo una conexion de telefonos con VoIP (No hay mucho para hacer mas que mirar)

TCP (TransmissionControl Protocol): Protocolo de capa de transporte orientado a la conexión (PDU=segmentos)

TCP es un protocolo de comunicación orientado a conexión, fiable a nivel de capa de transporte. Se diseño específicamente para proporcionar un flujo de bytes confiable de extremo a extremo a través de una interred no confiable.
TCP da soporte a muchos protocolos populares de capa de aplicación, como:

•HTTP
•SMTP
•SSH
•FTP (Protocolo de Transferencia de Archivos)

	Se usa como ejemplo el uso de FTP
	
Un servidor FTP es un programa que se ejecuta en un equipo servidor normalmente conectado a Internet. Su función es permitir el intercambio de datos entre diferentes servidores/ordenadores.
Cliente FTP: Cuando un navegador no está equipado con la función FTP, o si se quierecargar archivos en un ordenador remoto, se necesitará utilizar un programa cliente FTP.	

Guía de comandos FTP
Comando 		Acción que realiza
open <servidor>	Inicia una conexión con un servidor FTP.
close o disconnect 	Finaliza una conexión FTP sin cerrar el programa cliente.
quit 			Finaliza una conexión FTP y la sesión de trabajo con elprograma cliente.
delete 		archivo Borra un archivo en el servidor.
put <archivo> 		Envía un archivo al directorio activo del servidor.
rename <archivo>	Cambia el nombre a un archivo en el servidor.
get <archivo>		Obtiene un archivo.
dir 			Muestra el contenido del directorio en el que estamosen el servidor.
mkdir 			Crea el directorio indicado de forma remota.
	

