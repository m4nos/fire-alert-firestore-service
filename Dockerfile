FROM node:20-bookworm-slim

# Ensure production installs only
ENV NODE_ENV=production

WORKDIR /app

# Install dependencies with clean, reproducible installs
COPY package*.json ./
RUN npm ci --omit=dev

# Copy application source
COPY . .

# Ensure node user can write to working directory (for cache file)
RUN chown -R node:node /app

# Run as non-root user provided by the base image
USER node

# Start the cron-driven service
CMD ["npm", "start"]


