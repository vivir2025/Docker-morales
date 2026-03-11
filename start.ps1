# ==================================================
# Script de inicio para Docker - Morales
# ==================================================

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "  Sistema Morales - Inicio Docker  " -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# Verificar si Docker está instalado
try {
    $dockerVersion = docker --version
    Write-Host "✅ Docker detectado: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ ERROR: Docker no está instalado o no está en el PATH" -ForegroundColor Red
    Write-Host "   Instala Docker Desktop desde: https://www.docker.com/products/docker-desktop" -ForegroundColor Yellow
    exit 1
}

# Verificar si Docker está corriendo
$dockerInfo = docker info 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ ERROR: Docker no está corriendo" -ForegroundColor Red
    Write-Host "   Inicia Docker Desktop e intenta nuevamente" -ForegroundColor Yellow
    exit 1
}

# Verificar si la red compartida existe (creada por Cajibío)
$networkExists = docker network ls --filter name=ips_ips_network --format \"{{.Name}}\"
if (-not $networkExists) {
    Write-Host ""
    Write-Host "⚠️  ERROR: La red Docker compartida no existe" -ForegroundColor Red
    Write-Host "   Primero debes iniciar Cajibío (hub principal) que crea la red" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "   Ejecuta:" -ForegroundColor Yellow
    Write-Host "   cd C:\\docker\\cajibio" -ForegroundColor White
    Write-Host "   .\\start.ps1" -ForegroundColor White
    Write-Host ""
    exit 1
}

Write-Host ""
Write-Host "🚀 Iniciando contenedor de Morales..." -ForegroundColor Yellow
Write-Host ""

# Construir e iniciar contenedor
docker-compose up -d --build

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "===================================" -ForegroundColor Green
    Write-Host "  ✅ MORALES INICIADO EXITOSAMENTE  " -ForegroundColor Green
    Write-Host "===================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "🌐 Accede a Morales en:" -ForegroundColor Cyan
    Write-Host "   http://localhost/morales/" -ForegroundColor White
    Write-Host ""
    Write-Host "📄 Ver selector de municipios:" -ForegroundColor Yellow
    Write-Host "   http://localhost/" -ForegroundColor White
    Write-Host ""
    Write-Host "📊 Ver estado:" -ForegroundColor Yellow
    Write-Host "   docker-compose ps" -ForegroundColor White
    Write-Host ""
    Write-Host "📋 Ver logs:" -ForegroundColor Yellow
    Write-Host "   docker-compose logs -f" -ForegroundColor White
    Write-Host ""
    Write-Host "🛑 Detener:" -ForegroundColor Yellow
    Write-Host "   .\\stop.ps1" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "❌ ERROR: Hubo un problema al iniciar Docker" -ForegroundColor Red
    Write-Host "   Revisa los mensajes de error anteriores" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}
    Write-Host ""
    Write-Host "🛑 Detener contenedores:" -ForegroundColor Yellow
    Write-Host "   .\stop.ps1" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "❌ ERROR: Hubo un problema al iniciar Docker" -ForegroundColor Red
    Write-Host "   Revisa los mensajes de error anteriores" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}
