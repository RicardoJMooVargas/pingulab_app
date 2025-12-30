#!/bin/bash
# Script de deployment para Dockploy

set -e

echo "🚀 Iniciando deployment de Pingulab App..."

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Variables
COMPOSE_FILE="docker-compose.production.yaml"
ENV_FILE=".env.production"

# Verificar archivos necesarios
echo -e "${YELLOW}📋 Verificando archivos necesarios...${NC}"
if [ ! -f "$COMPOSE_FILE" ]; then
    echo -e "${RED}❌ Error: $COMPOSE_FILE no encontrado${NC}"
    exit 1
fi

if [ ! -f "config/passwords.yaml" ]; then
    echo -e "${RED}❌ Error: config/passwords.yaml no encontrado${NC}"
    echo "   Crea el archivo con contraseñas de producción"
    exit 1
fi

if [ ! -f "$ENV_FILE" ]; then
    echo -e "${YELLOW}⚠️  Warning: $ENV_FILE no encontrado, creando desde template...${NC}"
    cp .env.production.example $ENV_FILE
fi

# Build y deploy
echo -e "${GREEN}🔨 Construyendo imágenes...${NC}"
docker-compose -f $COMPOSE_FILE build

echo -e "${GREEN}🚀 Iniciando servicios...${NC}"
docker-compose -f $COMPOSE_FILE up -d

# Esperar a que la base de datos esté lista
echo -e "${YELLOW}⏳ Esperando a que PostgreSQL esté listo...${NC}"
sleep 10

# Aplicar migraciones
echo -e "${GREEN}📦 Aplicando migraciones...${NC}"
docker exec pingulab_api ./server --apply-migrations --mode=production || {
    echo -e "${RED}❌ Error al aplicar migraciones${NC}"
    exit 1
}

# Verificar estado
echo -e "${GREEN}✅ Verificando servicios...${NC}"
docker-compose -f $COMPOSE_FILE ps

# Health check
echo -e "${YELLOW}🏥 Realizando health check...${NC}"
sleep 5
if curl -f -s http://localhost:8080/serverpod > /dev/null; then
    echo -e "${GREEN}✅ Servidor respondiendo correctamente${NC}"
else
    echo -e "${RED}❌ Servidor no responde${NC}"
    docker logs pingulab_api
    exit 1
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✅ Deployment completado exitosamente${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "📊 Puedes ver los logs con:"
echo "   docker logs -f pingulab_api"
echo ""
echo "🌐 URLs disponibles:"
echo "   API:      https://api3d.mogastisolutions.engineer"
echo "   Insights: https://insights.api3d.mogastisolutions.engineer"
echo ""
