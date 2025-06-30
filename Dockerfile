# Build stage: use node:alpine for a small image
FROM node:alpine as builder

# Set working directory  inside the container
WORKDIR /app

# Copy and install dependencies first
COPY package.json .
RUN npm install

# Copy rest of the app code
COPY . .

# Build the app
RUN npm run build

# Serve stage: use Nginx to serve built static files
FROM nginx

# Copy the build output from builder stage into Nginx HTML dir
COPY --from=builder /app/build /usr/share/nginx/html
