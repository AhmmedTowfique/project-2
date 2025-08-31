FROM node:18-slim

# Add curl and tini for healthchecks / process management
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl tini && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/app

COPY package*.json ./
RUN npm ci && npm cache clean --force

COPY . .

# Default env vars (can be overridden in Kubernetes)
ENV PG_HOST=${PG_HOST:-postgres} \
    PG_PORT=${PG_PORT:-5432} \
    PG_USER=${PG_USER:-postgres} \
    PG_PASSWORD=${PG_PASSWORD:-postgres} \
    PG_DATABASE=${PG_DATABASE:-postgres} \
    PORT=${PORT:-5001}

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["node", "server.js"]
