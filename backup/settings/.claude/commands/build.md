# Build Commands

## Python Projects

### Virtual Environment Setup
```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
source venv/bin/activate  # macOS/Linux
venv\Scripts\activate     # Windows

# Install dependencies
pip install -r requirements.txt
pip install -e .  # For projects with setup.py/pyproject.toml
```

### Package Building
```bash
# Build distribution packages
python -m build

# Install in development mode
pip install -e .

# Create requirements file from current environment
pip freeze > requirements.txt
```

### Poetry Projects (if applicable)
```bash
# Install dependencies
poetry install

# Build package
poetry build

# Update dependencies
poetry update
```

## Node.js Projects

### Installation
```bash
# Install dependencies
npm install

# Clean install (remove node_modules first)
rm -rf node_modules package-lock.json
npm install

# Install specific package
npm install package-name

# Install dev dependency
npm install --save-dev package-name
```

### Building
```bash
# Development build
npm run build:dev

# Production build
npm run build

# Build and watch for changes
npm run build:watch
```

### TypeScript Projects
```bash
# Compile TypeScript
npx tsc

# Compile and watch
npx tsc --watch

# Type check without emit
npx tsc --noEmit
```

## Project-Specific Builds

### agent_unified
```bash
cd experiments/agent_unified

# Install with all optional dependencies
pip install -e ".[dev,docs]"

# Build documentation
mkdocs build

# Run quality checks before build
python scripts/quality_gates.py --gates all
```

### agent_autogen_implementation
```bash
cd experiments/agent_autogen_implementation

# Install AutoGen dependencies
pip install "autogen-agentchat" "autogen-ext[openai,anthropic]"

# Install project dependencies
pip install -r requirements.txt
```

### home_next_up
```bash
cd personal/home_next_up

# Backend setup
npm install

# Frontend setup
cd nextjs-client
npm install

# Build both
npm run build        # Backend
cd nextjs-client
npm run build        # Frontend
```

### app_drug_match
```bash
cd work/app_drug_match

# Install dependencies
npm install

# Initialize vector store
node scripts/initialize-fda-vector-store.js

# Build for production
npm run build
```

### home_tiller_enhancements
```bash
cd personal/home_tiller_enhancements

# Create virtual environment
python -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Install quality requirements
pip install -r requirements_quality.txt
```

## Docker Builds (where applicable)

### Generic Python App
```bash
# Build Docker image
docker build -t project-name .

# Build with specific tag
docker build -t project-name:v1.0.0 .

# Multi-stage build
docker build --target production -t project-name:prod .
```

### Generic Node.js App
```bash
# Build Docker image
docker build -t app-name .

# Build with build args
docker build --build-arg NODE_ENV=production -t app-name .
```

## Common Build Issues

### Python
```bash
# Clear pip cache
pip cache purge

# Upgrade pip
pip install --upgrade pip

# Install wheel for building
pip install wheel

# Force reinstall
pip install --force-reinstall package-name
```

### Node.js
```bash
# Clear npm cache
npm cache clean --force

# Rebuild native modules
npm rebuild

# Audit and fix vulnerabilities
npm audit fix

# Update npm
npm install -g npm@latest
```

## Pre-Build Checklist

1. **Environment Variables**
   ```bash
   # Check .env file exists
   test -f .env || cp .env.example .env
   ```

2. **Dependencies Updated**
   ```bash
   # Python
   pip list --outdated
   
   # Node.js
   npm outdated
   ```

3. **Tests Pass**
   ```bash
   # Python
   pytest
   
   # Node.js
   npm test
   ```

4. **Linting Clean**
   ```bash
   # Python
   black . && isort . && flake8
   
   # Node.js
   npm run lint
   ```

## Build Optimization

### Python
```bash
# Compile Python files
python -m compileall .

# Create wheel cache
pip wheel -r requirements.txt -w wheel-cache
```

### Node.js
```bash
# Production dependencies only
npm ci --production

# Bundle analyzer (if configured)
npm run analyze

# Tree shaking check
npm run build -- --stats
```