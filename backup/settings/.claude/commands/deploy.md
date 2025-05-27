# Deployment Commands

## Development Servers

### Python Projects
```bash
# Flask development server
flask run --debug

# Django development server
python manage.py runserver

# FastAPI with auto-reload
uvicorn main:app --reload --host 0.0.0.0 --port 8000

# Generic Python HTTP server
python -m http.server 8000
```

### Node.js Projects
```bash
# Start development server
npm run dev

# Start with specific port
PORT=3001 npm run dev

# Start with nodemon for auto-reload
npx nodemon src/index.js

# Start with pm2 for process management
pm2 start src/index.js --name app-name
```

## Production Deployment

### Process Management

#### PM2 (Node.js)
```bash
# Start application
pm2 start ecosystem.config.js

# List processes
pm2 list

# Monitor processes
pm2 monit

# Restart application
pm2 restart app-name

# Stop application
pm2 stop app-name

# Save process list
pm2 save

# Startup script
pm2 startup
```

#### Systemd (Python/Node.js)
```bash
# Copy service file
sudo cp myapp.service /etc/systemd/system/

# Reload systemd
sudo systemctl daemon-reload

# Start service
sudo systemctl start myapp

# Enable auto-start
sudo systemctl enable myapp

# Check status
sudo systemctl status myapp

# View logs
sudo journalctl -u myapp -f
```

### Environment Configuration

```bash
# Set production environment
export NODE_ENV=production
export FLASK_ENV=production

# Load environment from file
export $(cat .env | xargs)

# Use dotenv CLI
npx dotenv-cli -e .env.production -- node src/index.js
```

## Container Deployment

### Docker
```bash
# Run container
docker run -d \
  --name app-name \
  -p 3000:3000 \
  -e NODE_ENV=production \
  --restart unless-stopped \
  image-name:tag

# Run with env file
docker run -d \
  --name app-name \
  --env-file .env.production \
  -p 3000:3000 \
  image-name:tag

# View logs
docker logs -f app-name

# Execute command in container
docker exec -it app-name bash
```

### Docker Compose
```bash
# Start services
docker-compose up -d

# Start specific service
docker-compose up -d service-name

# View logs
docker-compose logs -f

# Restart services
docker-compose restart

# Stop and remove
docker-compose down

# Rebuild and restart
docker-compose up -d --build
```

## Cloud Deployment

### Heroku
```bash
# Login to Heroku
heroku login

# Create app
heroku create app-name

# Deploy
git push heroku main

# Set environment variables
heroku config:set KEY=value

# View logs
heroku logs --tail

# Run command
heroku run python manage.py migrate
```

### AWS (using EB CLI)
```bash
# Initialize Elastic Beanstalk
eb init

# Create environment
eb create production

# Deploy
eb deploy

# Open application
eb open

# SSH to instance
eb ssh

# View logs
eb logs
```

### DigitalOcean App Platform
```bash
# Install doctl
brew install doctl

# Authenticate
doctl auth init

# Create app
doctl apps create --spec app.yaml

# Deploy
doctl apps create-deployment <app-id>

# List apps
doctl apps list

# Get app details
doctl apps get <app-id>
```

## Database Deployment

### PostgreSQL
```bash
# Run migrations (Python/Django)
python manage.py migrate

# Run migrations (Node.js/Knex)
npx knex migrate:latest

# Create backup
pg_dump -U username -h localhost dbname > backup.sql

# Restore backup
psql -U username -h localhost dbname < backup.sql
```

### MongoDB
```bash
# Export data
mongodump --db dbname --out ./backup

# Import data
mongorestore --db dbname ./backup/dbname

# Run in Docker
docker run -d \
  --name mongodb \
  -p 27017:27017 \
  -v mongodb_data:/data/db \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=password \
  mongo:latest
```

## Reverse Proxy Setup

### Nginx
```bash
# Test configuration
nginx -t

# Reload configuration
nginx -s reload

# Common proxy configuration
sudo tee /etc/nginx/sites-available/app-name << EOF
server {
    listen 80;
    server_name example.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Enable site
sudo ln -s /etc/nginx/sites-available/app-name /etc/nginx/sites-enabled/
sudo nginx -s reload
```

### Apache
```bash
# Enable proxy modules
sudo a2enmod proxy proxy_http

# Configure virtual host
sudo tee /etc/apache2/sites-available/app-name.conf << EOF
<VirtualHost *:80>
    ServerName example.com
    
    ProxyRequests Off
    ProxyPreserveHost On
    
    ProxyPass / http://localhost:3000/
    ProxyPassReverse / http://localhost:3000/
</VirtualHost>
EOF

# Enable site
sudo a2ensite app-name
sudo systemctl reload apache2
```

## SSL/TLS Setup

### Let's Encrypt with Certbot
```bash
# Install certbot
sudo apt-get install certbot python3-certbot-nginx

# Obtain certificate
sudo certbot --nginx -d example.com -d www.example.com

# Test renewal
sudo certbot renew --dry-run

# Force renewal
sudo certbot renew --force-renewal
```

## Health Checks

### Application Health
```bash
# Simple HTTP check
curl -f http://localhost:3000/health || exit 1

# With authentication
curl -H "Authorization: Bearer token" http://localhost:3000/health

# Check specific endpoint
curl -X POST http://localhost:3000/api/health \
  -H "Content-Type: application/json" \
  -d '{"check": "database"}'
```

### System Health
```bash
# Check disk space
df -h

# Check memory
free -m

# Check processes
ps aux | grep node
ps aux | grep python

# Check ports
netstat -tlnp
lsof -i :3000
```

## Deployment Checklist

1. **Pre-deployment**
   ```bash
   # Run tests
   npm test
   pytest
   
   # Build assets
   npm run build
   
   # Check environment variables
   env | grep -E "NODE_ENV|DATABASE_URL"
   ```

2. **Database**
   ```bash
   # Backup current database
   # Run migrations
   # Verify schema
   ```

3. **Deploy**
   ```bash
   # Deploy code
   # Restart services
   # Run smoke tests
   ```

4. **Post-deployment**
   ```bash
   # Monitor logs
   # Check metrics
   # Verify functionality
   ```

## Rollback Procedures

```bash
# Git-based rollback
git checkout previous-tag
git push --force

# Docker rollback
docker stop app-name
docker run -d --name app-name image:previous-tag

# Database rollback
psql -U username -h localhost dbname < backup.sql

# PM2 rollback
pm2 deploy ecosystem.config.js production revert 1
```