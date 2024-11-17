#!/bin/bash

# Set Node.js path
export PATH=/home/u241225900/nodesource/node-v18.20.0-linux-x64/bin:$PATH

# Set environment variables
export NODE_ENV=production

# Create log directory if it doesn't exist
mkdir -p logs

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install --production >> logs/npm-install.log 2>&1
fi

# Start Strapi with PM2
if command -v pm2 &> /dev/null; then
    echo "Starting Strapi with PM2..."
    pm2 start npm --name "strapi" -- run start >> logs/pm2.log 2>&1
else
    echo "Starting Strapi directly..."
    npm run start >> logs/strapi.log 2>&1
fi
