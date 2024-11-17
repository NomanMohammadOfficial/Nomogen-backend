#!/bin/bash

# Configuration
FTP_HOST="api.nomanmohammad.com"
FTP_USER="u241225900.api.nomanmohammad.com"
FTP_PASS="Nomogen.123"
FTP_PORT=21
REMOTE_DIR="/"
LOCAL_DIR="/Users/noman/Documents/Coding/NomoGenai-backend"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "🚀 Starting deployment process..."

# Build the project
echo "📦 Building project..."
NODE_ENV=production npm run build

# Create deployment directory
DEPLOY_DIR="deploy"
rm -rf $DEPLOY_DIR
mkdir -p $DEPLOY_DIR

# Copy necessary files
echo "📋 Copying files..."
cp -r build config public src package.json package-lock.json .env.production start.sh .htaccess $DEPLOY_DIR/

# Create zip archive
echo "🗜️ Creating deployment package..."
zip -r strapi-deploy.zip $DEPLOY_DIR

# Upload using ncftp
echo "📤 Uploading to server..."
ncftpput -R -v -u "$FTP_USER" -p "$FTP_PASS" "$FTP_HOST" "$REMOTE_DIR" $DEPLOY_DIR/*

# Make start.sh executable
echo "🔑 Setting permissions..."
ncftp -u "$FTP_USER" -p "$FTP_PASS" "$FTP_HOST" << EOF
chmod 755 $REMOTE_DIR/start.sh
quit
EOF

# Cleanup
echo "🧹 Cleaning up..."
rm -rf $DEPLOY_DIR strapi-deploy.zip

echo -e "${GREEN}✅ Deployment completed!${NC}"
echo "
Next steps:
1. SSH into your Hostinger account
2. Navigate to the deployment directory
3. Run: chmod +x start.sh
4. Execute: ./start.sh

Remember to:
- Set up SSL certificate in Hostinger control panel
- Update DNS settings if needed
- Test the API endpoints
"
