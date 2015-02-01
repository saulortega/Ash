#!/bin/bash

####################################################################
 ###
  ##  Ash: Asterisk*Bash - Funciones en Bash para el AGI de Asterisk
  ##  Sitio web: https://github.com/saulortega/Ash
  ##  Autor: Saúl Ortega
  ##  Versión: 0.2
  ##
  ##
  ##  Historial de cambios:
  ##  
  ##  20150201-0130: Primer lanzamiento, apenas pruebas básicas de ejecución de algunos comandos en Asterisk
  ##  20150201-1505: Agregada función Log. Agregada función enviar que recoje las demás funciones y registra al log. Mejorada la función Grabar
  ##
 ###
####################################################################


Inicio=`date +"%Y-%m-%d %H:%M:%S %N"`


HabilitarLog=No
ArchivoLog=/var/log/ash.log



DirConfig=${AST_CONFIG_DIR}
ArcConfig=${AST_CONFIG_FILE}
DirModule=${AST_MODULE_DIR}
DirSpool=${AST_SPOOL_DIR}
DirMonitor=${AST_MONITOR_DIR}
DirVar=${AST_VAR_DIR}
DirData=${AST_DATA_DIR}
DirLog=${AST_LOG_DIR}
DirAGI=${AST_AGI_DIR}
DirKey=${AST_KEY_DIR}
DirRun=${AST_RUN_DIR}



if [[ "$HabilitarLog" =~ '^[sS][iIíÍ]$' ]]; then
	echo -e "\n">>$ArchivoLog
	echo "####################################################################">>$ArchivoLog
	echo "######## Inicio de ejecución: $Inicio ########">>$ArchivoLog
	echo "####################################################################">>$ArchivoLog
	echo -e "\n">>$ArchivoLog
	echo -e "****************** Variables de entorno ******************">>$ArchivoLog
	echo -e "Directorio de configuración:\t$DirConfig">>$ArchivoLog
	echo -e "Archivo de configuración:\t\t$ArcConfig">>$ArchivoLog
	echo -e "Directorio de módulos:\t\t$DirModule">>$ArchivoLog
	echo -e "Directorio spool:\t\t$DirSpool">>$ArchivoLog
	echo -e "Directorio monitor:\t\t$DirMonitor">>$ArchivoLog
	echo -e "Directorio var:\t\t\t$DirVar">>$ArchivoLog
	echo -e "Directorio data:\t\t$DirData">>$ArchivoLog
	echo -e "Directorio log:\t\t\t$DirLog">>$ArchivoLog
	echo -e "Directorio agi-bin:\t\t$DirAGI">>$ArchivoLog
	echo -e "Directorio key:\t\t\t$DirKey">>$ArchivoLog
	echo -e "Directorio run:\t\t\t$DirRun">>$ArchivoLog
	echo -e "\n">>$ArchivoLog
	echo -e "******** Variables de canal ********">>$ArchivoLog
fi




function Log() {
	if [[ "$HabilitarLog" =~ '^[sS][iIíÍ]$' ]]; then
		if [ ${1} = "VariableCanal" ]; then
			echo -e "${2}:\t${4}${3}">>$ArchivoLog
		else
			echo ${@}>>$ArchivoLog
		fi
		
	else
		break
	fi
}




linea='init'
while [ -n "${linea}" ]; do
	read linea

	if [[ "$linea" =~ '^agi_request: (.*)' ]]; then
		EstaAGI=${BASH_REMATCH[1]}
		Log VariableCanal EstaAGI $EstaAGI

	elif [[ "$linea" =~ '^agi_channel: (.*)' ]]; then
		Canal=${BASH_REMATCH[1]}
		Log VariableCanal Canal $Canal "\t"

	elif [[ "$linea" =~ '^agi_language: (.*)' ]]; then
		Idioma=${BASH_REMATCH[1]}
		Log VariableCanal Idioma $Idioma "\t"

	elif [[ "$linea" =~ '^agi_type: (.*)' ]]; then
		Tipo=${BASH_REMATCH[1]}
		Log VariableCanal Tipo $Tipo "\t"

	elif [[ "$linea" =~ '^agi_uniqueid: (.*)' ]]; then
		Identificador=${BASH_REMATCH[1]}
		Log VariableCanal Identificador $Identificador

	elif [[ "$linea" =~ '^agi_version: (.*)' ]]; then
		Version=${BASH_REMATCH[1]}
		Log VariableCanal Versión $Version

	elif [[ "$linea" =~ '^agi_callerid: (.*)' ]]; then
		CID=${BASH_REMATCH[1]}
		NumeroLlamante=${BASH_REMATCH[1]}
		Log VariableCanal CID $CID "\t"

	elif [[ "$linea" =~ '^agi_calleridname: (.*)' ]]; then
		NombreLlamante=${BASH_REMATCH[1]}
		Log VariableCanal "Nombre CID" $NombreLlamante

	elif [[ "$linea" =~ '^agi_callingpres: (.*)' ]]; then
		Presentacion=${BASH_REMATCH[1]}
		Log VariableCanal Presentación $Presentacion

	elif [[ "$linea" =~ '^agi_callingani2: (.*)' ]]; then
		ANI2=${BASH_REMATCH[1]}
		Log VariableCanal ANI2 $ANI2 "\t"

	elif [[ "$linea" =~ '^agi_callington: (.*)' ]]; then
		TON=${BASH_REMATCH[1]}
		Log VariableCanal TON $TON "\t"

	elif [[ "$linea" =~ '^agi_callingtns: (.*)' ]]; then
		TNS=${BASH_REMATCH[1]}
		Log VariableCanal TNS $TNS "\t"

	elif [[ "$linea" =~ '^agi_dnid: (.*)' ]]; then
		DNID=${BASH_REMATCH[1]}
		DID=${BASH_REMATCH[1]}
		Log VariableCanal DID $DID "\t"

	elif [[ "$linea" =~ '^agi_rdnis: (.*)' ]]; then
		RDNIS=${BASH_REMATCH[1]}
		Log VariableCanal RDNIS $RDNIS "\t"

	elif [[ "$linea" =~ '^agi_context: (.*)' ]]; then
		Contexto=${BASH_REMATCH[1]}
		Log VariableCanal Contexto $Contexto

	elif [[ "$linea" =~ '^agi_extension: (.*)' ]]; then
		Extension=${BASH_REMATCH[1]}
		Log VariableCanal Extensión $Extension

	elif [[ "$linea" =~ '^agi_priority: (.*)' ]]; then
		Prioridad=${BASH_REMATCH[1]}
		Log VariableCanal Prioridad $Prioridad

	elif [[ "$linea" =~ '^agi_enhanced: (.*)' ]]; then
		Mejorado=${BASH_REMATCH[1]}
		Log VariableCanal "AGI Mejorado" $Mejorado

	elif [[ "$linea" =~ '^agi_accountcode: (.*)' ]]; then
		CodigoCuenta=${BASH_REMATCH[1]}
		Log VariableCanal "Código de cuenta" $CodigoCuenta

	elif [[ "$linea" =~ '^agi_threadid: (.*)' ]]; then
		ThreadID=${BASH_REMATCH[1]}
		Log VariableCanal ThreadID $ThreadID

	###Mejorar código de los siguientes con un for que se adapte a la cantidad de argumentos recibidos, y disminuir código
	elif [[ "$linea" =~ '^agi_arg_1: (.*)' ]]; then
		Argumento1=${BASH_REMATCH[1]}
		Log VariableCanal Argumento1 $Argumento1

	elif [[ "$linea" =~ '^agi_arg_2: (.*)' ]]; then
		Argumento2=${BASH_REMATCH[1]}
		Log VariableCanal Argumento2 $Argumento2

	elif [[ "$linea" =~ '^agi_arg_3: (.*)' ]]; then
		Argumento3=${BASH_REMATCH[1]}
		Log VariableCanal Argumento3 $Argumento3

	elif [[ "$linea" =~ '^agi_arg_4: (.*)' ]]; then
		Argumento4=${BASH_REMATCH[1]}
		Log VariableCanal Argumento4 $Argumento4

	elif [[ "$linea" =~ '^agi_arg_5: (.*)' ]]; then
		Argumento5=${BASH_REMATCH[1]}
		Log VariableCanal Argumento5 $Argumento5

	elif [[ "$linea" =~ '^agi_arg_6: (.*)' ]]; then
		Argumento6=${BASH_REMATCH[1]}
		Log VariableCanal Argumento6 $Argumento6

	elif [[ "$linea" =~ '^agi_arg_7: (.*)' ]]; then
		Argumento7=${BASH_REMATCH[1]}
		Log VariableCanal Argumento7 $Argumento7

	elif [[ "$linea" =~ '^agi_arg_8: (.*)' ]]; then
		Argumento8=${BASH_REMATCH[1]}
		Log VariableCanal Argumento8 $Argumento8

	elif [[ "$linea" =~ '^agi_arg_9: (.*)' ]]; then
		Argumento9=${BASH_REMATCH[1]}
		Log VariableCanal Argumento9 $Argumento9

	fi
done





if [[ "$HabilitarLog" =~ '^[sS][iIíÍ]$' ]]; then
	echo -e "\n">>$ArchivoLog
	echo "******** Comandos enviados a Asterisk ********">>$ArchivoLog
fi





function enviar() {  
	echo ${@}  
	Log ${@}
}





function Contestar() {
	enviar ANSWER
}

function Interrumpir() {
	enviar ASYNCAGI BREAK
}

function EstadoDeCanal() {
	enviar CHANNEL STATUS ${1}
}

function ControlDeAudio() {
	### CONTROL STREAM FILE FILENAME ESCAPE_DIGITS SKIPMS FFCHAR REWCHR PAUSECHR OFFSETMS
	### Nombre de archivo sin extensión - Dígitos de escape - Milisegundos a adelantar o retroceder - Caracter para adelantar (Predeterminado #) - Caracter para retroceder (Predeterminado *) - Caracter para pausar - Offset en milisegundos (### A partir de Asterisk 12 únicamente ###)
	enviar CONTROL STREAM FILE ${1} \"${2}\" \"${3}\" \"${4}\" \"${5}\" \"${6}\" \"${7}\"
}

function BorrarFamilyKey() {
	### FAMILY - KEY
	enviar DATABASE DEL ${1} ${2}
}

function BorrarFamilyKeytree() {
	### FAMILY - KEYTREE
	enviar DATABASE DELTREE ${1} ${2}
}

function LeerBD() {
	### FAMILY - KEY
	enviar DATABASE GET ${1} ${2}
}

function EscribirBD() {
	### FAMILY - KEY - VALUE
	enviar DATABASE PUT ${1} ${2} ${3}
}

function Ejecutar() {
	### Aplicación - Opciones
	enviar EXEC ${1} ${2}
}

function SolicitarMarcación() {
	### Nombre de archivo sin extensión - Tiempo de espera - Cantidad máxima de dígitos a recibir
	enviar GET DATA ${1} ${2} ${3}
	### Parece no funcionar, o no conozco muy bien su funcionamiento
}

function SolicitarMarcacion() {
	enviar GET DATA ${1} ${2} ${3}
}

function ObtenerVariableCompleja() {
	### Nombre de la variable - Nombre del canal
	enviar GET FULL VARIABLE ${1} ${2}
}

function SolicitarOpción() {
	### Nombre de archivo sin extensión - Dígitos de escape - Tiempo de espera
	enviar GET OPTION ${1} \"${2}\" ${3}
}

function SolicitarOpcion() {
	enviar GET OPTION ${1} \"${2}\" ${3}
}

function ObtenerVariable() {
	### Nombre de la variable
	enviar GET VARIABLE ${1}
}

function Subrutina() {
	### Contexto - Extensión - Prioridad - Argumento (opcional)
	enviar GOSUB ${1} ${2} ${3} ${4}
}

function Colgar() {
	### Nombre del canal
	enviar HANGUP ${1}
}

function NoHacerNada() {
	### Texto opcional para que quede registrado en el log. ¿Mejor usar Registrar (Verbose)?
	enviar NOOP ${1}
}

function ObtenerCaracter() {
	### Tiempo de espera en milisegundos (0 para infinito)
	enviar RECEIVE CHAR ${1}
}

function ObtenerTexto() {
	### Tiempo de espera en milisegundos (0 para infinito)
	enviar RECEIVE TEXT ${1}
}

function Grabar() {
	### Nombre de archivo - Formato - Dígitos de escape - Tiempo máximo de grabación en milisegundos (-1 sin límite) - OFFSET SAMPLES (Opcional) - BEEP (opcional) - S=SILENCE (opcional)
	### Ejemplo de uso: /tmp/algo gsm "#" 9000
	enviar RECORD FILE ${1} ${2} \"${3}\" ${4} ${5} ${6} ${7}
}

function DecirCaracteres() {
	### Números, letras, u otros - Dígitos de escape
	enviar SAY ALPHA ${1} \"${2}\"
}

function DecirFecha() {
	### Segundos transcurridos desde el 1 de enero de 1970, UTC - Dígitos de escape
	enviar SAY DATE ${1} \"${2}\"
}

function DecirFechaHora() {
	### Segundos transcurridos desde el 1 de enero de 1970, UTC - Dígitos de escape - Formato (Por defecto "ABdY 'digits/at' IMp") - Zona horaria
	enviar SAY DATETIME ${1} \"${2}\" ${3} ${4}
}

function DecirDígitos() {
	### Dígitos - Dígitos de escape
	enviar SAY DIGITS ${1} \"${2}\"
}

function DecirDigitos() {
	enviar SAY DIGITS ${1} \"${2}\"
}

function DecirNúmero() {
        ### Número - Dígitos de escape - Género
	enviar SAY NUMBER ${1} \"${2}\" \"${3}\"
}

function DecirNumero() {
	enviar SAY NUMBER ${1} \"${2}\" \"${3}\"
}

function DecirAlfabetoRadiofónico() {
	### Caracteres - Dígitos de escape
	enviar SAY PHONETIC ${1} \"${2}\"
}

function DecirAlfabetoRadiofonico() {
	enviar SAY PHONETIC ${1} \"${2}\"
}

function DecirAlfabetoOACI() {
	enviar SAY PHONETIC ${1} \"${2}\"
}

function DecirHora() {
	### Segundos transcurridos desde las 00:00 - Dígitos de escape
	enviar SAY TIME ${1} \"${2}\"
	### No funciona muy bien
}

function EnviarImagen() {
	### Nombre de archivo de imagen sin extensión. ¿Ruta absoluta? ¿Hay un directorio destinado a ello?
	enviar SEND IMAGE ${1}
}

function EnviarTexto() {
	### Más de una palabra a enviar
	enviar SEND TEXT \"${1}\"
}

function ColgarEn() {
	### Segundos dentro de los que se colgará el canal
	enviar SET AUTOHANGUP ${1}
}

function CID() {
	### Número a establecer como CID
	enviar SET CALLERID ${1}
}

function Contexto() {
	### Contexto al que continuar al salir de la aplicación
	enviar SET CONTEXT ${1}
}

function Extensión() {
	### Extensión a la que continuar al salir de la aplicación
	enviar SET EXTENSION ${1}
}

function Extension() {
	enviar SET EXTENSION ${1}
}

function Música() {
	### On u Off - Tipo de música
	enviar SET MUSIC ${1} ${2}
}

function Musica() {
	enviar SET MUSIC ${1} ${2}
}

function Prioridad() {
	### Prioridad
	enviar SET PRIORITY ${1}
}

function Variable() {
	### Nombre a dar a la variable - Valor
	enviar SET VARIABLE ${1} ${2}
}

function ActivarGramática() {
	### Nombre de la gramática
	enviar SPEECH ACTIVATE GRAMMAR ${1}
}

function ActivarGramatica() {
	enviar SPEECH ACTIVATE GRAMMAR ${1}
}

function CrearHabla() {
	### Motor de habla
	enviar SPEECH CREATE ${1}
}

function DesactivarGramática() {
	### Nombre de la gramática
	enviar SPEECH DEACTIVATE GRAMMAR ${1}
}

function DesactivarGramatica() {
	enviar SPEECH DEACTIVATE GRAMMAR ${1}
}

function DestruirHabla() {
	enviar SPEECH DESTROY
}

function CargarGramática() {
	### Nombre de a gramática - Ruta a la gramática
	enviar SPEECH LOAD GRAMMAR ${1} ${2}
}

function CargarGramatica() {
	enviar SPEECH LOAD GRAMMAR ${1} ${2}
}

function ReconocerHabla() {
	### Audio a reproducir mientras se espera el habla - Tiempo de espera - Offset
	enviar SPEECH RECOGNIZE ${1} ${2} ${3}
}

function MotorHabla() {
	### Nombre - Valor
	enviar SPEECH SET ${1} ${2}
}

function DescargarGramática() {
	### Nombre de la gramática
	enviar SPEECH UNLOAD GRAMMAR ${1}
}

function DescargarGramatica() {
	enviar SPEECH UNLOAD GRAMMAR ${1}	
}

function Reproducir() {
	### Nombre del archivo sin extensión - Dígitos de escape - SAMPLE OFFSET
	enviar STREAM FILE ${1} \"${2}\" ${3}
	### Asterisk lo interpreta correctamente y sin errores, pero no lo reproduce
}

function TDD() {
	### On u Off
	enviar TDD MODE ${1}
}

function Registrar() {
	### Mensaje a registrar en el log - Nivel (de 1 (más importantes) a 4 (menos importantes))
	enviar VERBOSE \"${1}\" ${2}
}

function EsperarDígito() {
	### Tiempo de espera en milisegundos (-1 para infinito) a esperar por un dígito DTMF
	enviar WAIT FOR DIGIT ${1}
	### Parece no funcionar, o su funcionamiento es diferente al que creo
}

function EsperarDigito() {
	enviar WAIT FOR DIGIT ${1}
}






Fin=`date +"%Y-%m-%d %H:%M:%S %N"`

if [[ "$HabilitarLog" =~ '^[sS][iIíÍ]$' ]]; then
	echo -e "\n">>$ArchivoLog
	echo "#####################################################################">>$ArchivoLog
	echo "########## Fin de ejecución: $Fin ##########">>$ArchivoLog
	echo "#####################################################################">>$ArchivoLog
	echo -e "\n">>$ArchivoLog
fi

exit 0
