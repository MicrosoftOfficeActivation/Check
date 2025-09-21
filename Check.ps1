

# =================================================================
#               CONFIGURACIÓN
# =================================================================


$listaDeClaves = @(

    "8R2J6-T4Y7U-1I5O9-P3A8S-D6F2G",
    "H5J1K-L9Z4X-C7V3B-N8M2Q-W6E9R",
    "T1Y5U-I9O3P-A7S2D-F6G9H-J4K8L",
    "Z3X7C-V2B6N-M1Q5W-E9R4T-Y8U2I",
    "4O8P1-A5S9D-F3G7H-J2K6L-Z9X5C",
    "V4B8N-M3Q7W-E1R5T-Y9U4I-O8P3A",
    "S6D1F-G5H9J-K3L7Z-X2C6V-B9N5M",
    "Q1W5E-R9T3Y-U7I2O-P6A9S-D4F8G",
    "H2J6K-L1Z5X-C9V3B-N7M2Q-W6E9R",
    "T4Y8U-I3O7P-A2S6D-F1G5H-J9K3L",
    "Z7X2C-V6B1N-M5Q9W-E4R8T-Y3U7I",
    "O2P6A-S1D5F-G9H3J-K7L2Z-X6C1V",
    "B5N9M-Q4W8E-R3T7Y-U2I6O-P1A5S",
    "D9F3G-H7J2K-L6Z1X-C5V9B-N4M8Q",
    "W3E7R-T2Y6U-I1O5P-A9S4D-F8G3H"
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
