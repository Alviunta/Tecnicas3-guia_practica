VLAN
Una VLAN es un método de crear redes lógicas e independientes dentro de una misma red física.
Una VLAN consiste en una red de host que se comportan como si estuviesen conectados al mismo switch, aunque pueden estar en realidad conectados físicamente a diferentes segmentos de una red de área local.

Las VLAN se configuran en los dispositivos de red, los hosts no tienen idea.

EN UN SWITCH:

Switch>enable 
Switch#config terminal 
Switch(config)#VLAN 2 				//Creamos la VLAN CON UN ID
Switch(config-vlan)#name <NOMBRE>	 	//Le asignamos un nombre (opcional)
Switch(config-vlan)#exit			//Para crear otra VLAN DEBEMOS salir del estado de config-vlan actual

Switch>enable 
Switch1(config)#interface fastEthernet0/6	//entramos a la configuracion de la interfaz de conexion 
Switch1(config-if)#switchport access vlan 2	//Le asignamos una VLAN con el correspondiente ID
Switch1(config-if)#end

Para ver como quedo la configuracion podemos usar los siguiente comandos

Switch# show vlan
Switch# show vlan id <vlan-number>
Switch# show interfaces switchport.

Enlace troncal:
Configuración de enlaces troncales
Un enlace troncal es un enlace entre los switchs, o entre un switch y un router, para comunicar el tráfico de todas las VLANs independientemente, bajo el protocolo 802.1q

Configuración de enlaces troncales
Un enlace troncal es un enlace entre los switchs, o entre un switch y un router, para comunicar
el tráfico de todas las VLANs independientemente, bajo el protocolo 802.1q.


Switch>enable 
Switch#config terminal 
Switch1(config)#interface fastEthernet0/20	//entramos a la configuracion de la interfaz de conexion con el otro switch/router
Switch1(config-if)#switchport mode trunk	//Indicamos que es un enlace troncal
Switch1(config-if)#end

Para ver como quedo la configuracion podemos usar los siguiente comandos
Switch1#show interface trunk

EN UN ROUTER

Router>enable
Router#config terminal
Router(config)#interface fastEthernet 0/0.1			//Configuramos el puerto de conexion troncal, subdividiendo (por eso el .1)
Router(config-subif)#encapsulation dot1Q 2			//Configuramos el protocolo .1q con el numero de VLAN que quiero
Router(config-subif)#ip address 192.168.1.1 255.255.255.0	//Asignamos direccion IP a la interfaz DEBE ESTAR EN LA RED ES LA PUERTA DE ENLACE (gateway)
Router(config-subif)#exit




