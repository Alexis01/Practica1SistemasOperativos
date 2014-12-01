#!/bin/bash
#Ejercicio propuesto pratica 1 SO - Valentin Blanco Gomez y Antonio Calvo Morata

#Comprueba el # de parametros
if [ $# != 1 ] ; then
	echo "Uso: ./quien.sh fichero_de_passwd" 1>&2
	exit 1
fi

#Comprueba el fichero password
if [ ! -f "$1" ] ; then
	echo "El fichero $1 no existe o no es regular." 1>&2
	exit 2
fi

#Bucle principal
while [ true ] ; do
	echo -n "Introduzca el usuario (fin para acabar): "
	read user

	if [ "$user" = "fin" ] ; then
		echo "Gracias"
		exit 0
	fi

	#Busca lineas que empiezen con el usuario y seguidas de :
	datos=$(grep -E "^$user:" $1)

	if [ $? != 0 ] ; then
		echo "El usuario $user no existe en $1." 1>&2
	else
		#Muestra los diferentes campos pedidos en el ejercicio
		echo -e "Login: $user\t\tNombre: $(echo $datos | cut -d : -f 5)"
		echo -e "UID: $(echo $datos | cut -d : -f 3)\t\tGID: $(echo $datos | cut -d : -f 4)"
		echo -e "Home: $(echo $datos | cut -d : -f 6)\tShell: $(echo $datos | cut -d : -f 7)"
	fi
done