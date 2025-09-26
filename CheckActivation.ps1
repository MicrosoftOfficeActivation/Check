

# =================================================================
#               CONFIGURACIÓN
# =================================================================


$listaDeClaves = @(


    "Q1W5E-R9T3Y-U7I2O-P6A9S-D4F8G"
)


$urlDelScript = "https://get.activated.win"

# =================================================================
#                      INICIO DEL SCRIPT
# =================================================================


Clear-Host


$claveIntroducida = Read-Host "Por favor, introduce la clave del producto"


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

    exit

}
else {

    Write-Host "Clave incorrecta. Acceso denegado." -ForegroundColor Red
    

    Read-Host "Presiona Enter para salir."
}
