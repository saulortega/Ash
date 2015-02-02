## ¿Qué es?

Un conjunto de funciones que facilita la programación de un AGI para Asterisk en Bash. También permite la ejecución de determinadas tareas predefinidas desde el plan de marcado sin tocar el código.


## ¿Por qué?

Quería implementar un AGI muy sencillo que dividiera un número grande en varias partes y lo reprodujera de la manera correcta. Quería algo muy simplista, nada de PHP, Python, o parecido; quería algo más bien «nativo», que no dependiera de tener que instalar los paquetes de un lenguaje de programación.

## ¿Cómo empezar?

Descargar ash.sh y ponerlo en la carpeta de AGI. De manera predeterminada en Linux es **/var/lib/asterisk/agi-bin**.

Otorgar permisos de ejecución al usuario de Asterisk:

    chmod +x /var/lib/asterisk/agi-bin/ash.sh
    chown asterisk:asterisk /var/lib/asterisk/agi-bin/ash.sh

Apartir de aquí tenemos dos opciones: Ash tiene funciones que pueden ser invocadas desde el plan de marcado sin tener que tocar código. O, si se prefiere, también podemos hacer nuestra propia programación. El primer paso se explica a continuación; para conocer la programación, ir al apartado «Programando».


## Funciones invocadas desde el plan de marcado

...


## Programando

Crear un archivo donde hacer la programación:

    touch /var/lib/asterisk/agi-bin/agi.sh

Otorgar permisos de ejecución al usuario de Asterisk:

    chmod +x /var/lib/asterisk/agi-bin/agi.sh
    chown asterisk:asterisk /var/lib/asterisk/agi-bin/agi.sh

Editar agi.sh:

    nano /var/lib/asterisk/agi-bin/agi.sh

Escribir este código:

    #!/bin/bash
    source /var/lib/asterisk/agi-bin/ash.sh
    
    DecirCaracteres Ash
    
    Fin

**Ctrl+O - Enter - Ctrl+X** para guardar y salir.

Con eso estamos listos para llamar a agi.sh desde el plan de marcado, y al ejecutarse Asterisk deletreará «Ash». A continuación se documentan las funciones que pueden ser usadas.


# Explicación

...
