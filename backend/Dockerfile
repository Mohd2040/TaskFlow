# Use official Node.js LTS image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package.json files before copying the rest (to benefit from Docker layer cache)
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy source code
COPY . .

# Expose the correct port
EXPOSE 5000

# Start the app
CMD ["npm", "start"]
