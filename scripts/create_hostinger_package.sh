#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}🚀 Creating Hostinger-compatible deployment package...${NC}"

# Build the project
echo -e "${YELLOW}📦 Building project...${NC}"
npm run build

# Create deployment directory
echo -e "${YELLOW}📋 Preparing deployment package...${NC}"
rm -rf deploy
mkdir -p deploy

# Copy necessary files
echo -e "${YELLOW}📋 Copying files...${NC}"
cp -r config deploy/
cp -r public deploy/
cp -r src deploy/
cp package.json deploy/
cp package-lock.json deploy/
cp .env.production deploy/.env
cp .htaccess deploy/

# Copy build directory
cp -r build deploy/

# Create server.js for Hostinger
cat > deploy/server.js << 'EOF'
const strapi = require('@strapi/strapi');

strapi().start();
EOF

# Update package.json for Hostinger
node -e "
const pkg = require('./deploy/package.json');
pkg.scripts.start = 'node server.js';
pkg.scripts.postinstall = 'npm run build';
pkg.engines = { node: '>=18.0.0 <=20.x.x' };
require('fs').writeFileSync('./deploy/package.json', JSON.stringify(pkg, null, 2));
"

# Create zip archive
echo -e "${YELLOW}🗜️ Creating deployment package...${NC}"
cd deploy && zip -r ../hostinger-deploy.zip . && cd ..

# Clean up
echo -e "${YELLOW}🧹 Cleaning up...${NC}"
rm -rf deploy

echo -e "${GREEN}✅ Package created: hostinger-deploy.zip${NC}

Next steps:
1. Log in to your Hostinger control panel
2. Go to Website > Node.js
3. Upload hostinger-deploy.zip
4. Set Node.js version to 18.x
5. Set the following environment variables in Hostinger:
   - NODE_ENV=production
   - DATABASE_CLIENT=mysql
   - DATABASE_HOST=srv1680.hstgr.io
   - DATABASE_PORT=3306
   - DATABASE_NAME=u241225900_nomogen
   - DATABASE_USERNAME=u241225900_nomogen
   - DATABASE_PASSWORD=Nomogen.123
   - DATABASE_SSL=false
   - ADMIN_JWT_SECRET=(your secret)
6. Click Deploy

Note: The application will automatically build and start when deployed."
