<#
.SYNOPSIS
    Este script solicita una clave de producto al usuario y la valida contra
    una lista predefinida de claves válidas.

.DESCRIPTION
    El script está diseñado para actuar como una puerta de enlace o un "launcher".
    Solo si el usuario proporciona una de las claves correctas definidas en la lista,
    se ejecutará el comando 'Invoke-RestMethod | Invoke-Expression' para correr
    código alojado en una URL.

.EXAMPLE
    .\verificador_multiclave.ps1
    Por favor, introduce la clave del producto: CLAVE-ALPHA-001
    Clave correcta. Iniciando la ejecución...
    (Se ejecuta el script de la URL)

.EXAMPLE
    .\verificador_multiclave.ps1
    Por favor, introduce la clave del producto: clave-incorrecta
    Clave incorrecta. Acceso denegado.
#>

# =================================================================
#               CONFIGURACIÓN (MODIFICA ESTOS VALORES)
# =================================================================

# 1. Define aquí la LISTA de claves de producto que consideras válidas.
#    Puedes añadir tantas como necesites, separadas por comas.
#    El formato es @("clave1", "clave2", "clave3", ...)
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
# El operador '-contains' verifica si un elemento existe dentro de una colección.
# Es sensible a mayúsculas y minúsculas por defecto.
if ($listaDeClaves -contains $claveIntroducida) {
    # Si la clave introducida está en la lista, se ejecuta este bloque.
    Write-Host "Clave correcta. Iniciando la ejecución..." -ForegroundColor Green

    try {
        # Descarga el contenido de la URL y lo ejecuta inmediatamente.
        # irm (Invoke-RestMethod) descarga el contenido.
        # | (pipe) pasa el contenido descargado al siguiente comando.
        # iex (Invoke-Expression) ejecuta el contenido como si fuera un script de PowerShell.
        irm $urlDelScript | iex
    }
    catch {
        # Si ocurre un error durante la descarga o ejecución (ej: URL no válida), se captura aquí.
        Write-Host "ERROR: No se pudo descargar o ejecutar el script desde la URL." -ForegroundColor Red
        Write-Host "Detalles del error: $($_.Exception.Message)" -ForegroundColor Yellow
    }

}
else {
    # Si la clave introducida NO está en la lista, se ejecuta este bloque.
    Write-Host "Clave incorrecta. Acceso denegado." -ForegroundColor Red
}

# (Opcional) Pausa el script al final para que la ventana no se cierre de inmediato
# si se ejecuta haciendo doble clic.
# Read-Host "Presiona Enter para salir."
