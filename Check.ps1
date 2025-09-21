<#
.SYNOPSIS
    Este script solicita una clave de producto al usuario y la valida contra
    una lista predefinida. Si la clave es correcta, ejecuta un script remoto
    y cierra la ventana de PowerShell.

.DESCRIPTION
    El script está diseñado para actuar como una puerta de enlace o un "launcher".
    Solo si el usuario proporciona una de las claves correctas definidas en la lista,
    se ejecutará el comando 'Invoke-RestMethod | Invoke-Expression'. Tras la
    ejecución exitosa, la sesión de PowerShell finalizará.

.EXAMPLE
    .\verificador_autocierre.ps1
    Por favor, introduce la clave del producto: PROYECTO-DELTA-456
    Clave correcta. Iniciando la ejecución...
    (Se ejecuta el script de la URL y la ventana se cierra)

.EXAMPLE
    .\verificador_autocierre.ps1
    Por favor, introduce la clave del producto: clave-incorrecta
    Clave incorrecta. Acceso denegado.
    (La ventana permanece abierta mostrando el error)
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
        # Descarga el contenido de la URL y lo ejecuta inmediatamente.
        irm $urlDelScript | iex
    }
    catch {
        # Si ocurre un error durante la descarga o ejecución, se captura aquí.
        Write-Host "ERROR: No se pudo descargar o ejecutar el script desde la URL." -ForegroundColor Red
        Write-Host "Detalles del error: $($_.Exception.Message)" -ForegroundColor Yellow
        # Pausamos para que el usuario pueda leer el error antes de que la ventana se cierre.
        Read-Host "Presiona Enter para salir."
        # Salimos del script también en caso de error.
        exit
    }

    # =================================================================
    #               CIERRE AUTOMÁTICO (NUEVA ADICIÓN)
    # =================================================================
    # Si la ejecución fue exitosa, el comando 'exit' cierra la ventana
    # de PowerShell.
    exit

}
else {
    # Si la clave introducida NO está en la lista, se ejecuta este bloque.
    Write-Host "Clave incorrecta. Acceso denegado." -ForegroundColor Red
    
    # Pausamos el script para que la ventana no se cierre de inmediato y el
    # usuario pueda leer el mensaje de error.
    Read-Host "Presiona Enter para salir."
}
