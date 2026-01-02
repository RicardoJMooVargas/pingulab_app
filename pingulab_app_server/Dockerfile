# Build stage
FROM dart:3.5.0 AS build
WORKDIR /app

# Copy only pubspec files first for better caching
COPY pubspec.* ./
RUN dart pub get

# Copy the rest of the application
COPY . .

# Generate Serverpod protocol files
RUN dart pub global activate serverpod_cli && \
    dart pub global run serverpod_cli generate

# Compile the server executable
RUN dart compile exe bin/main.dart -o bin/server

# Final stage
FROM alpine:latest

# Install runtime dependencies
RUN apk add --no-cache \
    gettext \
    netcat-openbsd \
    postgresql-client

# Environment variables
ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

# Copy runtime dependencies
COPY --from=build /runtime/ /

# Copy compiled server executable
COPY --from=build /app/bin/server server

# Copy configuration files and resources
COPY --from=build /app/config/ config/
COPY --from=build /app/web/ web/
COPY --from=build /app/migrations/ migrations/

# This file is required to enable the endpoint log filter in Insights.
COPY --from=build /app/lib/src/generated/protocol.yaml lib/src/generated/protocol.yaml

# Create passwords.yaml from environment variables at runtime
RUN echo "production:" > config/passwords.yaml && \
    echo "  database: \"\${POSTGRES_PASSWORD}\"" >> config/passwords.yaml && \
    echo "  redis: \"\${REDIS_PASSWORD}\"" >> config/passwords.yaml

# Expose ports
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# Create init users SQL script
RUN echo "-- Create default users if they don't exist" > /init_users.sql && \
    echo "INSERT INTO users (email, \"passwordHash\", nombre, apellido, rol, activo, created)" >> /init_users.sql && \
    echo "VALUES " >> /init_users.sql && \
    echo "  ('admin@pingulab.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'Admin', 'Principal', 0, TRUE, NOW())," >> /init_users.sql && \
    echo "  ('operador@pingulab.com', '6ca8a22e0f87d7ad0a072f0ac4fd89e8f5b2c2e93c0d95e0c9a3d1dbb4ff5a59', 'Operador', 'General', 1, TRUE, NOW())," >> /init_users.sql && \
    echo "  ('viewer@pingulab.com', '2c2da6f8c4f51e6dc59b5a8dbf23432f3e8f2b72a1cd19d1e7f8c0e5b3a1d4f2', 'Viewer', 'Solo lectura', 2, TRUE, NOW())" >> /init_users.sql && \
    echo "ON CONFLICT (email) DO NOTHING;" >> /init_users.sql

# Create entrypoint script that substitutes env vars and applies migrations
RUN echo '#!/bin/sh' > /entrypoint.sh && \
    echo 'set -e' >> /entrypoint.sh && \
    echo 'echo "🔧 Configuring passwords..."' >> /entrypoint.sh && \
    echo 'envsubst < config/passwords.yaml > config/passwords.tmp' >> /entrypoint.sh && \
    echo 'mv config/passwords.tmp config/passwords.yaml' >> /entrypoint.sh && \
    echo '' >> /entrypoint.sh && \
    echo 'echo "⏳ Waiting for database to be ready..."' >> /entrypoint.sh && \
    echo 'until nc -z postgres 5432; do' >> /entrypoint.sh && \
    echo '  echo "Database not ready, waiting..."' >> /entrypoint.sh && \
    echo '  sleep 2' >> /entrypoint.sh && \
    echo 'done' >> /entrypoint.sh && \
    echo 'echo "✅ Database is ready"' >> /entrypoint.sh && \
    echo '' >> /entrypoint.sh && \
    echo 'echo "📦 Checking migrations..."' >> /entrypoint.sh && \
    echo 'if [ ! -f /app/.migrations_applied ]; then' >> /entrypoint.sh && \
    echo '  echo "⏳ Applying Serverpod migrations..."' >> /entrypoint.sh && \
    echo '  ./server --apply-migrations --mode=$runmode || echo "⚠️  Migration failed, continuing..."' >> /entrypoint.sh && \
    echo '  sleep 3' >> /entrypoint.sh && \
    echo '  echo "⏳ Applying post-migration setup..."' >> /entrypoint.sh && \
    echo '  PGPASSWORD=$POSTGRES_PASSWORD psql -h postgres -U postgres -d pingulab_app -f /app/migrations/post_migration_setup.sql 2>&1 | grep -E "NOTICE|ERROR" || echo "✅ Post-migration completed"' >> /entrypoint.sh && \
    echo '  touch /app/.migrations_applied' >> /entrypoint.sh && \
    echo '  echo "✅ All migrations applied"' >> /entrypoint.sh && \
    echo 'else' >> /entrypoint.sh && \
    echo '  echo "✅ Migrations already applied"' >> /entrypoint.sh && \
    echo 'fi' >> /entrypoint.sh && \
    echo '' >> /entrypoint.sh && \
    echo 'echo "👥 Initializing default users..."' >> /entrypoint.sh && \
    echo 'PGPASSWORD=$POSTGRES_PASSWORD psql -h postgres -U postgres -d pingulab_app -f /init_users.sql 2>/dev/null || echo "⚠️  Users initialization skipped (might already exist)"' >> /entrypoint.sh && \
    echo '' >> /entrypoint.sh && \
    echo 'echo "🚀 Starting Serverpod..."' >> /entrypoint.sh && \
    echo 'exec ./server --mode=$runmode --server-id=$serverid --logging=$logging --role=$role' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

# Define the entrypoint command
ENTRYPOINT ["/entrypoint.sh"]
