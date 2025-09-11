<#
.SYNOPSIS
    Este script solicita una clave de producto, la valida contra una lista y,
    si es correcta, ejecuta un script remoto y cierra la ventana de PowerShell
    inmediatamente después de la ejecución.

.DESCRIPTION
    Diseñado como un "launcher" seguro por clave. Tras una validación exitosa,
    descarga y ejecuta un script de una URL. La sesión de PowerShell finaliza
    automáticamente en cuanto el script remoto termina su ejecución, sin dejar
    rastro visible de la consola.

.EXAMPLE
    .\verificador_cierre_inmediato.ps1
    Por favor, introduce la clave del producto: ACCESO-BETA-789
    Clave correcta. Iniciando la ejecución...
    (Se ejecuta el script de la URL y la ventana se cierra instantáneamente al finalizar)
#>

# =================================================================
#               CONFIGURACIÓN (MODIFICA ESTOS VALORES)
# =================================================================

# 1. Define aquí la LISTA de claves de producto que consideras válidas.
$listaDeClaves = @(
    "CLAVE-ALPHA-001",
    "MI-CLAVE-SECRETA-123",
    "PROYECTO-DELTA-456",
    "ACCESO-BETA-789"
)

# 2. Introduce la URL completa del script que quieres descargar y ejecutar.
$urlDelScript = "https://get.activated.win"

# =================================================================
#                      INICIO DEL SCRIPT
# =================================================================

# Limpia la pantalla para una mejor presentación (opcional).
Clear-Host

# Solicita al usuario que introduzca la clave.
$claveIntroducida = Read-Host "Por favor, introduce la clave del producto"

# Compara la clave introducida por el usuario con la lista de claves válidas.
if ($listaDeClaves -contains $claveIntroducida) {
    # Si la clave introducida está en la lista, se ejecuta este bloque.
    Write-Host "Clave correcta. Iniciando la ejecución..." -ForegroundColor Green

    try {
        # =================================================================
        #        EJECUCIÓN Y CIERRE INMEDIATO (MODIFICACIÓN CLAVE)
        # =================================================================
        # El punto y coma (;) actúa como separador. PowerShell ejecutará
        # la pipeline 'irm | iex' por completo, y solo cuando esta termine,
        # ejecutará el comando 'exit'.
        irm $urlDelScript | iex; exit
    }
    catch {
        # Si ocurre un error DURANTE la descarga (ej: URL incorrecta), se captura aquí.
        # NOTA: Si el script descargado tiene un error, es posible que la ventana
        # se cierre antes de que puedas verlo, dependiendo del tipo de error.
        Write-Host "ERROR: No se pudo descargar o iniciar el script desde la URL." -ForegroundColor Red
        Write-Host "Detalles del error: $($_.Exception.Message)" -ForegroundColor Yellow
        # Pausamos para que el usuario pueda leer el error de descarga.
        Read-Host "Presiona Enter para salir."
        exit
    }
}
else {
    # Si la clave introducida NO está en la lista, se ejecuta este bloque.
    Write-Host "Clave incorrecta. Acceso denegiado." -ForegroundColor Red
    
    # Pausamos el script para que la ventana no se cierre de inmediato.
    Read-Host "Presiona Enter para salir."
}
