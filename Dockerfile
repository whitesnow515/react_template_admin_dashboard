# Step 1: Build stage
FROM node:latest as build-stage

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock) to the Docker environment
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

# Build the app
RUN npm run build

# Serve stage
FROM nginx:stable-alpine as serve-stage
COPY --from=build-stage /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]