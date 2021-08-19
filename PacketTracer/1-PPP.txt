//PARA CONFIGURAR UN ENLACE PPP CON AUTENTICACION CHAP
CHAP  (CHAP, en inglés: Challenge Handshake Authentication Protocol) es un método de autentificación usado por servidores accesibles vía PPP. CHAP verificaperiódicamente la identidad del cliente remoto usando un intercambio de información de tresetapas. Esto ocurre cuando se establece el enlace inicial 
y puede pasar de nuevo en cualquier momento de la comunicación. La verificación se basa en un secreto compartido (como una contraseña).

1-Después del establecimiento del enlace, el agente autenticador manda un mensaje que «pide verificarse» al usuario.
2-El usuario responde con un valor calculado usando una función hash de un solo sentido, como la suma de comprobación MD5.
3-El autenticador verifica la respuesta con el resultado de su propio cálculo de la función hash. Si el valor coincide, el autenticador informa de la verificación, de lo contrario terminaría la conexión.
4-A intervalos aleatorios el autenticador manda una nueva «comprobación de veracidad», con lo que se repite el proceso.
CHAP protege contra los ataques de REPLAY mediante el uso de un identificador que se va incrementando y un valor de verificación variable. CHAP requiere que el cliente mantenga el secreto disponible en texto plano.

// Router 1 

R1>enable
R1#configure terminal
R1(config)#hostname R1  				/Nombre del host
R1(config)#username R2 password aaaa			//Password para comunicarse con el usuario R2
R1(config)#interface serial2/0				//Configuro interfaz serial2/0
R1(config-if)#ip address 192.168.2.10 255.255.255.0	//asigno direccion Ip y mascara
R1(config-if)#clock rate 128000			//Configuro velocidad de transmision
R1(config-if)#encapsulation ppp			//Protocolo PPP
R1(config-if)#ppp authentication chap			//Autenticacion CHAP
R1(config-if)#no shut					//Enciendo el puerto
R1(config-if)#end					//salgo del modo de configuracion

// Router 2

R2>enable
R2#configure terminal
R2(config-if)#hostname R2				//Nombre del host
R2(config)#username R1 password aaaa			//Password para comunicarse con el usuario R1
R2(config)#interface serial2/0				//Configuro interfaz serial2/0
R2(config-if)#ip address 192.168.2.20 255.255.255.0	//asigno direccion Ip y mascara
R2(config-if)#encapsulation ppp			//Protocolo PPP
R2(config-if)#ppp authentication chap			//Autenticacion CHAP
R2(config-if)#no shut					//Enciendo el puerto
R2(config-if)#end					//salgo del modo de configuracion

Hacer un ping desde el Router R1 al router R2. Desde la consola de R1 hacemos:
R1>enable
R1#ping 192.168.2.10
Para ver la configuración del puerto serial 2/0.
R1>enable
R1#show interface serial2/0

//PARA CONFIGURAR UN ENLACE PPP CON AUTENTICACION PAP

PAP son las siglas de Password Authentication Protocol un protocolo simple de autenticación para autenticar un usuario contra un servidor de acceso remoto o contra un proveedor de servicios de internet. PAP es un subprotocolo usado por la autenticación del protocolo PPP (Point to Point Protocol), validando a un usuario que accede a ciertos recursos. PAP transmite contraseñas o passwords en ASCII sin cifrar, por lo que se considera inseguro. PAP se usa como último recurso cuando el servidor de acceso remoto no soporta un protocolo de autenticación más fuerte.

// Router 1:
R1>enable
R1#configure terminal
R1(config)#hostname R1					
R1(config)#username R2 password aaaa
R1(config)#interface serial2/0
R1(config-if)#ip address 192.168.2.10 255.255.255.0
R1(config-if)#clock rate 128000
R1(config-if)#encapsulation ppp
R1(config-if)#ppp authentication pap			//Autenticacion PAP
R1(config-if)#ppp pap sent-username R1 password aaaa	//Envio decredenciales
R1(config-if)#no shut
R1(config-if)#end

// Router 2:

R2>enable
R2#configure terminal
R2(config-if)#hostname R2
R2(config)#username R1 password aaaa
R2(config)#interface serial2/0
R2(config-if)#ip address 192.168.2.20 255.255.255.0
R2(config-if)#encapsulation ppp
R2(config-if)#ppp authentication pap			//Autenticacion PAP
R2(config-if)#ppp pap sent-username R2 password aaaa	//Envio de credenciales
R2(config-if)#no shut
R2(config-if)#end

Hacer un ping desde el Router R1 al router R2. Desde la consola de R1 hacemos:
R1>enable
R1#ping 192.168.2.10
Para ver la configuración del puerto serial 2/0.
R1>enable
R1#show interface serial2/0
Observe el tipo de encapsulación que utiliza, guarde esta configuración.
Para ver el tipo de configuración del puerto:
R1#show interface serial2/0
Para ver la negociación del protocolo PPP utilizamos los comandos:
R1#debug ppp authentication
R1#debug ppp negotiation
