#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}🚀 Creating deployment package...${NC}"

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
cp .env.production deploy/
cp .htaccess deploy/

# Copy build directory
cp -r build deploy/

# Create start script
cat > deploy/start.sh << 'EOF'
#!/bin/bash
export NODE_ENV=production
node node_modules/@strapi/strapi/bin/strapi.js start
EOF
chmod +x deploy/start.sh

# Create zip archive
echo -e "${YELLOW}🗜️ Creating deployment package...${NC}"
zip -r deploy.zip deploy

# Clean up
echo -e "${YELLOW}🧹 Cleaning up...${NC}"
rm -rf deploy

echo -e "${GREEN}✅ Package created: deploy.zip${NC}

Next steps:
1. Log in to your Hostinger control panel
2. Navigate to File Manager
3. Upload deploy.zip to the root directory
4. Extract the zip file
5. SSH into your account
6. Navigate to the deployment directory
7. Run: chmod +x start.sh
8. Execute: ./start.sh

Remember to:
- Set up SSL certificate in Hostinger control panel
- Update DNS settings if needed
- Test the API endpoints"
