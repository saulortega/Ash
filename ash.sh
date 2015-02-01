#!/bin/bash


############################
### Variables de entorno ###
############################
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
############################
### Variables de entorno ###
############################



linea='init'
while [ -n "${linea}" ]; do
	read linea

	if [[ "$linea" =~ '^agi_request: (.*)' ]]; then
		EstaAGI=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_channel: (.*)' ]]; then
		Canal=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_language: (.*)' ]]; then
		Idioma=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_type: (.*)' ]]; then
		Tipo=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_uniqueid: (.*)' ]]; then
		Identificador=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_version: (.*)' ]]; then
		Version=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_callerid: (.*)' ]]; then
		CID=${BASH_REMATCH[1]}
		NumeroLlamante=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_calleridname: (.*)' ]]; then
		NombreLlamante=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_callingpres: (.*)' ]]; then
		Presentacion=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_callingani2: (.*)' ]]; then
		ANI2=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_callington: (.*)' ]]; then
		TON=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_callingtns: (.*)' ]]; then
		TNS=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_dnid: (.*)' ]]; then
		DNID=${BASH_REMATCH[1]}
		DID=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_rdnis: (.*)' ]]; then
		RDNIS=${BASH_REMATCH[1]}
		###Número redireccionado

	elif [[ "$linea" =~ '^agi_context: (.*)' ]]; then
		Contexto=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_extension: (.*)' ]]; then
		Extension=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_priority: (.*)' ]]; then
		Prioridad=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_enhanced: (.*)' ]]; then
		Mejorado=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_accountcode: (.*)' ]]; then
		CodigoCuenta=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_threadid: (.*)' ]]; then
		ThreadID=${BASH_REMATCH[1]}

	###Mejorar código de los siguientes con un for que se adapte a la cantidad de argumentos recibidos, y disminuir código
	elif [[ "$linea" =~ '^agi_arg_1: (.*)' ]]; then
		Argumento1=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_arg_2: (.*)' ]]; then
		Argumento2=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_arg_3: (.*)' ]]; then
		Argumento3=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_arg_4: (.*)' ]]; then
		Argumento4=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_arg_5: (.*)' ]]; then
		Argumento5=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_arg_6: (.*)' ]]; then
		Argumento6=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_arg_7: (.*)' ]]; then
		Argumento7=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_arg_8: (.*)' ]]; then
		Argumento8=${BASH_REMATCH[1]}

	elif [[ "$linea" =~ '^agi_arg_9: (.*)' ]]; then
		Argumento9=${BASH_REMATCH[1]}

	fi
done




#################
### Funciones ###
#################

### Verificar su uso en http://www.voip-info.org/wiki/view/Asterisk+AGI

function Contestar() {
	echo "ANSWER"
}

function Interrumpir() {
	echo "ASYNCAGI BREAK"
}

function EstadoDeCanal() {
	echo "CHANNEL STATUS ${1}"
}

function ControlDeAudio() {
	### Nombre de archivo sin extensión - Dígitos de escape - Milisegundos a adelantar o retroceder - Caracter para adelantar (Predeterminado #) - Caracter para retroceder (Predeterminado *) - Caracter para pausar - Offset en milisegundos (### A partir de Asterisk 12 únicamente ###)
	echo "CONTROL STREAM FILE ${1} \"${2}\" \"${3}\" \"${4}\" \"${5}\" \"${6}\" \"${7}\""
}

function BorrarFamilyKey() {
	### FAMILY - KEY
	echo "DATABASE DEL ${1} ${2}"
}

function BorrarFamilyKeytree() {
	### FAMILY - KEYTREE
	echo "DATABASE DELTREE ${1} ${2}"
}

function LeerBD() {
	### FAMILY - KEY
	echo "DATABASE GET ${1} ${2}"
}

function EscribirBD() {
	### FAMILY - KEY - VALUE
	echo "DATABASE PUT ${1} ${2} ${3}"
}

function Ejecutar() {
	### Aplicación - Opciones
	echo "EXEC ${1} ${2}"
}

function SolicitarMarcación() {
	### Nombre de archivo sin extensión - Tiempo de espera - Cantidad máxima de dígitos a recibir
	echo "GET DATA ${1} ${2} ${3}"
}

function SolicitarMarcacion() {
	SolicitarMarcación ${1} ${2} ${3}
}

function ObtenerVariableCompleja() {
	### Nombre de la variable - Nombre del canal
	echo "GET FULL VARIABLE ${1} ${2}"
}

function SolicitarOpción() {
	### Nombre de archivo sin extensión - Dígitos de escape - Tiempo de espera
	echo "GET OPTION ${1} ${2} ${3}"
}

function SolicitarOpción() {
	SolicitarOpción ${1} ${2} ${3}
}

function ObtenerVariable() {
	### Nombre de la variable
	echo "GET VARIABLE ${1}"
}

function Subrutina() {
	### Contexto - Extensión - Prioridad - Argumento (opcional)
	echo "GOSUB ${1} ${2} ${3} ${4}"
}

function Colgar() {
	### Nombre del canal
	echo "HANGUP ${1}"
}

function NoHacerNada() {
	echo "NOOP"
	### ¿Se le puede pasar valores arbitrarios para registrar en log?
}

function ObtenerCaracter() {
	### Tiempo de espera en milisegundos (0 para infinito)
	echo "RECEIVE CHAR ${1}"
}

function ObtenerTexto() {
	### Tiempo de espera en milisegundos (0 para infinito)
	echo "RECEIVE TEXT ${1}"
}

function Grabar() {
	### Nombre de archivo - Formato - Dígitos de escape - Tiempo máximo de grabación en milisegundos (-1 sin límite) - OFFSET SAMPLES (Opcional) - BEEP (opcional) - S=SILENCE (opcional)
	echo "RECORD FILE ${1} ${2} ${3} ${4}"
	### Últimos tres argumentos omitidos. ¿"Offset samples" y "beep" van literal? La "s" del último argumento sí es literal. Agregar condicionas complejas para manejar estos argumentos.
}

function DecirCaracteres() {
	### Números, letras, u otros - Dígitos de escape
	echo "SAY ALPHA ${1} ${2}"
}

function DecirFecha() {
	### Segundos transcurridos desde el 1 de enero de 1970, UTC - Dígitos de escape
	echo "SAY DATE ${1} ${2}"
}

function DecirFechaHora() {
	### Segundos transcurridos desde el 1 de enero de 1970, UTC - Dígitos de escape - Formato (Por defecto "ABdY 'digits/at' IMp") - Zona horaria
	echo "SAY DATETIME ${1} ${2} ${3} ${4}"
}

function DecirDígitos() {
	### Dígitos - Dígitos de escape
	echo "SAY DIGITS ${1} \"${2}\""
}

function DecirDigitos() {
	DecirDígitos ${1} ${2}
}

function DecirNúmero() {
        ### Número - Dígitos de escape - Género
        echo "SAY NUMBER ${1} \"${2}\" \"${3}\""
}

function DecirNumero() {
        DecirNúmero ${1} ${2} ${3}
}

function DecirAlfabetoRadiofónico() {
	### Caracteres - Dígitos de escape
	echo "SAY PHONETIC ${1} \"${2}\""
}

function DecirAlfabetoRadiofonico() {
	DecirAlfabetoRadiofónico ${1} ${2}
}

function DecirAlfabetoOACI() {
	DecirAlfabetoRadiofónico ${1} ${2}
}

function DecirHora() {
	### Segundos transcurridos desde el 1 de enero de 1970, UTC - Dígitos de escape
	echo "SAY TIME ${1} \"${2}\""
}

function EnviarImagen() {
	### Nombre de archivo de imagen sin extensión. ¿Ruta absoluta? ¿Hay un directorio destinado a ello?
	echo "SEND IMAGE ${1}"
}

function EnviarTexto() {
	### Más de una palabra a enviar
	echo "SEND TEXT \"${1}\""
}

function ColgarEn() {
	### Segundos dentro de los que se colgará el canal
	echo "SET AUTOHANGUP ${1}"
}

function CID() {
	### Número a establecer como CID
	echo "SET CALLERID ${1}"
}

function Contexto() {
	### Contexto al que continuar al salir de la aplicación
	echo "SET CONTEXT ${1}"
}

function Extensión() {
	### Extensión a la que continuar al salir de la aplicación
	echo "SET EXTENSION ${1}"
}

function Extension() {
	Extensión ${1}
}

function Música() {
	### On u Off - Tipo de música
	echo "SET MUSIC ${1} ${2}"
}

function Musica() {
	Música ${1} ${2}
}

function Prioridad() {
	### Prioridad
	echo "SET PRIORITY ${1}"
}

function Variable() {
	### Nombre a dar a la variable - Valor
	echo "SET VARIABLE ${1} ${2}"
}

function ActivarGramática() {
	### Nombre de la gramática
	echo "SPEECH ACTIVATE GRAMMAR ${1}"
}

function ActivarGramatica() {
	ActivarGramática ${1}
}

function CrearHabla() {
	### Motor de habla
	echo "SPEECH CREATE ${1}"
}

function DesactivarGramática() {
	### Nombre de la gramática
	echo "SPEECH DEACTIVATE GRAMMAR ${1}"
}

function DesactivarGramatica() {
	DesactivarGramática ${1}
}

function DestruirHabla() {
	echo "SPEECH DESTROY"
}

function CargarGramática() {
	### Nombre de a gramática - Ruta a la gramática
	echo "SPEECH LOAD GRAMMAR ${1} ${2}"
}

function CargarGramatica() {
	CargarGramática ${1} ${2}
}

function ReconocerHabla() {
	### Audio a reproducir mientras se espera el habla - Tiempo de espera - Offset
	echo "SPEECH RECOGNIZE ${1} ${2} ${3}"
}

function MotorHabla() {
	### Nombre - Valor
	echo "SPEECH SET ${1} ${2}"
}

function DescargarGramática() {
	### Nombre de la gramática
	echo "SPEECH UNLOAD GRAMMAR ${1}"
}

function DescargarGramatica() {
	DescargarGramática ${1}
}

function Reproducir() {
	### Nombre del archivo sin extensión - Dígitos de escape - SAMPLE OFFSET
	echo "STREAM FILE ${1} \"${2}\" ${3}"
}

function TDD() {
	### On u Off
	echo "TDD MODE ${1}"
}

function Registrar() {
	### Mensaje a registrar en el log - Nivel (de 1 (más importantes) a 4 (menos importantes))
	echo "VERBOSE \"${1}\" ${2}"
}

function EsperarDígito() {
	### Tiempo de espera en milisegundos (-1 para infinito) a esperar por un dígito DTMF
	echo "WAIT FOR DIGIT ${1}"
}

function EsperarDigito() {
	EsperarDígito ${1}
}

function () {

}



exit 0
