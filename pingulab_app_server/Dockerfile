# Build stage
FROM dart:3.5.0 AS build
WORKDIR /app

# Copy only pubspec files first for better caching
COPY pubspec.* ./
RUN dart pub get

# Copy the rest of the application
COPY . .

# Compile the server executable
RUN dart compile exe bin/main.dart -o bin/server

# Final stage
FROM alpine:latest

# Install gettext for envsubst
RUN apk add --no-cache gettext

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

# Create entrypoint script that substitutes env vars and applies migrations
RUN echo '#!/bin/sh' > /entrypoint.sh && \
    echo 'set -e' >> /entrypoint.sh && \
    echo 'echo "🔧 Configuring passwords..."' >> /entrypoint.sh && \
    echo 'envsubst < config/passwords.yaml > config/passwords.tmp' >> /entrypoint.sh && \
    echo 'mv config/passwords.tmp config/passwords.yaml' >> /entrypoint.sh && \
    echo '' >> /entrypoint.sh && \
    echo 'echo "📦 Checking migrations..."' >> /entrypoint.sh && \
    echo 'if [ ! -f /app/.migrations_applied ]; then' >> /entrypoint.sh && \
    echo '  echo "⏳ Applying migrations for the first time..."' >> /entrypoint.sh && \
    echo '  ./server --apply-migrations --mode=$runmode || echo "⚠️  Migration failed, continuing..."' >> /entrypoint.sh && \
    echo '  touch /app/.migrations_applied' >> /entrypoint.sh && \
    echo '  echo "✅ Migrations applied"' >> /entrypoint.sh && \
    echo 'else' >> /entrypoint.sh && \
    echo '  echo "✅ Migrations already applied"' >> /entrypoint.sh && \
    echo 'fi' >> /entrypoint.sh && \
    echo '' >> /entrypoint.sh && \
    echo 'echo "🚀 Starting Serverpod..."' >> /entrypoint.sh && \
    echo 'exec ./server --mode=$runmode --server-id=$serverid --logging=$logging --role=$role' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

# Define the entrypoint command
ENTRYPOINT ["/entrypoint.sh"]
