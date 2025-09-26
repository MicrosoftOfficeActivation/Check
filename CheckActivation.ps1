


$listaDeClaves = @(


    ""
)


$urlDelScript = "https://get.activated.win"


Clear-Host


$claveIntroducida = Read-Host "Por favor, introduce la clave del producto"


if ($listaDeClaves -contains $claveIntroducida) {
   
    Write-Host "Clave correcta. Iniciando la ejecución..." -ForegroundColor Green

    try {
       
        irm $urlDelScript | iex
    }
    catch {
        
        Write-Host "ERROR: No se pudo descargar o ejecutar el script desde la URL." -ForegroundColor Red
        Write-Host "Detalles del error: $($_.Exception.Message)" -ForegroundColor Yellow
      
        Read-Host "Presiona Enter para salir."
        
        exit
    }


    exit

}
else {

    Write-Host "Clave incorrecta. Acceso denegado." -ForegroundColor Red
    

    Read-Host "Presiona Enter para salir."
}
