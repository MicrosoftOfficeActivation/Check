<#
.SYNOPSIS
    Launcher seguro que valida una clave de producto contra un servidor remoto
    para garantizar un único uso.

.DESCRIPTION
    Este script contacta a una API central para validar la clave introducida.
    El servidor determina si la clave es válida y si ya ha sido utilizada.
    Este método es robusto y previene la manipulación por parte del usuario.
#>

# =================================================================
#               CONFIGURACIÓN (MODIFICA ESTOS VALORES)
# =================================================================

# 1. URL de tu validador PHP en el servidor.
#    ¡IMPORTANTE! Debe terminar con "?key="
$urlValidador = "https://multi.jonatanaurumvault.uk/office/validate_key.php?key="

# 2. URL del script que se ejecutará si la clave es válida.
$urlDelScript = "https://get.activated.win"

# =================================================================
#                      INICIO DEL SCRIPT
# =================================================================

Clear-Host
$claveIntroducida = Read-Host "Por favor, introduce la clave del producto"

# Construimos la URL completa para la consulta a la API.
$urlConsulta = $urlValidador + $claveIntroducida

try {
    # Hacemos la llamada al servidor y guardamos su respuesta.
    Write-Host "Contactando con el servidor de validación..."
    $respuestaServidor = Invoke-RestMethod -Uri $urlConsulta -Method Get
}
catch {
    Write-Host "ERROR: No se pudo contactar con el servidor de validación." -ForegroundColor Red
    Write-Host "Verifica tu conexión a internet o la URL del validador." -ForegroundColor Yellow
    Read-Host "Presiona Enter para salir."
    exit
}

# Analizamos la respuesta del servidor.
switch ($respuestaServidor) {
    "OK" {
        # ¡Éxito! La clave es válida y no ha sido usada.
        Write-Host "Clave correcta. Iniciando la ejecución..." -ForegroundColor Green
        try {
            # Ejecutamos el script remoto y cerramos la ventana.
            irm $urlDelScript | iex; exit
        }
        catch {
            Write-Host "ERROR: No se pudo ejecutar el script remoto." -ForegroundColor Red
            Read-Host "Presiona Enter para salir."
            exit
        }
    }
    "INVALID_KEY" {
        # La clave no está en la lista de claves válidas.
        Write-Host "Clave incorrecta. Acceso denegado." -ForegroundColor Red
    }
    "KEY_ALREADY_USED" {
        # La clave es válida, pero ya fue usada.
        Write-Host "Clave correcta, pero ya ha sido utilizada. Acceso denegado." -ForegroundColor Yellow
    }
    default {
        # Cualquier otra respuesta del servidor.
        Write-Host "Respuesta desconocida del servidor: $respuestaServidor" -ForegroundColor Red
    }
}

# Pausamos para que el usuario pueda leer el mensaje de error.
Read-Host "Presiona Enter para salir."
