# Use Node.js 18 Alpine for smaller image size
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apk add --no-cache git

# Copy package files
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy source code
COPY . .

# Build the application
RUN yarn build

# Create public directory if it doesn't exist
RUN mkdir -p public

# Create a simple index.html for the root endpoint
RUN echo '<!DOCTYPE html><html><head><title>Flowise Embed</title></head><body><h1>Flowise Embed Server</h1><p>Server is running</p></body></html>' > public/index.html

# Expose port
EXPOSE 3001

# Set environment variables
ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=3001

# Start the server
CMD ["node", "server.js"]