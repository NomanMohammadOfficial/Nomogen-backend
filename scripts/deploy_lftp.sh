#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}🚀 Starting deployment process...${NC}"

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

# Create FTP script
cat > deploy/upload.lftp << EOF
open -u u241225900.api.nomanmohammad.com,Nomogen.123 ftp://api.nomanmohammad.com
set ssl:verify-certificate no
mirror -R deploy/ /
bye
EOF

# Upload using lftp
echo -e "${YELLOW}📤 Uploading to server...${NC}"
lftp -f deploy/upload.lftp

# Clean up
echo -e "${YELLOW}🧹 Cleaning up...${NC}"
rm -rf deploy

echo -e "${GREEN}✅ Deployment completed!${NC}

Next steps:
1. SSH into your Hostinger account
2. Navigate to the deployment directory
3. Run: chmod +x start.sh
4. Execute: ./start.sh

Remember to:
- Set up SSL certificate in Hostinger control panel
- Update DNS settings if needed
- Test the API endpoints"
