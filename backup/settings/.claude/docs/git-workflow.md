# Git Workflow and Hooks

## Pre-commit Setup

B Doc's projects use pre-commit hooks to enforce code quality before commits.

### Global Pre-commit Hook

Install a global pre-commit hook that works across all projects:

```bash
# Create global hooks directory
mkdir -p ~/.git-templates/hooks

# Make it the default for new repos
git config --global init.templateDir ~/.git-templates

# Copy the hook to existing repos
cp ~/.git-templates/hooks/pre-commit .git/hooks/
chmod +x .git/hooks/pre-commit
```

### Pre-commit Hook Script

```bash
#!/usr/bin/env bash
# ABOUTME: Global pre-commit hook
# Runs project-specific quality checks

set -e

# Get repository root
REPO_ROOT=$(git rev-parse --show-toplevel)
cd "$REPO_ROOT"

echo "Running pre-commit checks..."

# Check if .pre-commit-config.yaml exists
if [ -f ".pre-commit-config.yaml" ]; then
    # Use pre-commit framework
    PRE_COMMIT_ALLOW_NO_CONFIG=1 pre-commit run --stage pre-commit
else
    # Run project-specific checks
    if [ -f "scripts/pre-commit.sh" ]; then
        ./scripts/pre-commit.sh
    else
        # Default checks based on project type
        
        # Python projects
        if [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
            echo "Running Python checks..."
            
            # Check for syntax errors
            find . -name "*.py" -not -path "./venv/*" -not -path "./.venv/*" | xargs python -m py_compile
            
            # Run black in check mode
            if command -v black &> /dev/null; then
                black --check .
            fi
            
            # Run flake8
            if command -v flake8 &> /dev/null; then
                flake8 .
            fi
            
            # Check for debug statements
            if grep -r "import pdb" --include="*.py" .; then
                echo "ERROR: Found pdb imports"
                exit 1
            fi
        fi
        
        # Node.js projects
        if [ -f "package.json" ]; then
            echo "Running Node.js checks..."
            
            # Run linting if available
            if grep -q "\"lint\":" package.json; then
                npm run lint
            fi
            
            # Check for console.log in production code
            if grep -r "console.log" --include="*.js" --include="*.ts" --exclude-dir=node_modules --exclude-dir=tests --exclude-dir=__tests__ src/; then
                echo "WARNING: Found console.log statements in src/"
            fi
        fi
    fi
fi

# Check for sensitive data
echo "Checking for sensitive data..."

# Check for common secret patterns
if git diff --cached --name-only | xargs grep -E "(api_key|apikey|api-key|password|passwd|pwd|secret|token|PRIVATE KEY)" 2>/dev/null; then
    echo "WARNING: Possible sensitive data detected. Please review your changes."
    echo "Use 'git diff --cached' to review staged changes."
    read -p "Continue with commit? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check file size
for file in $(git diff --cached --name-only); do
    if [ -f "$file" ]; then
        size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
        if [ "$size" -gt 5242880 ]; then  # 5MB
            echo "ERROR: $file is larger than 5MB"
            exit 1
        fi
    fi
done

echo "Pre-commit checks passed ✓"
```

## Pre-commit Framework Configuration

For projects using the pre-commit framework, create `.pre-commit-config.yaml`:

### Python Projects
```yaml
# ABOUTME: Pre-commit configuration for Python projects
# Enforces code quality standards
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
        args: ['--maxkb=5000']
      - id: check-json
      - id: check-merge-conflict
      - id: check-ast
      - id: debug-statements
      - id: mixed-line-ending

  - repo: https://github.com/psf/black
    rev: 23.12.1
    hooks:
      - id: black
        language_version: python3

  - repo: https://github.com/pycqa/isort
    rev: 5.13.2
    hooks:
      - id: isort
        args: ["--profile", "black"]

  - repo: https://github.com/pycqa/flake8
    rev: 7.0.0
    hooks:
      - id: flake8
        args: ['--max-line-length=88', '--extend-ignore=E203']

  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.8.0
    hooks:
      - id: mypy
        additional_dependencies: [types-all]

  - repo: https://github.com/pycqa/bandit
    rev: 1.7.6
    hooks:
      - id: bandit
        args: ['-ll', '-i']
        files: .py$
```

### Node.js Projects
```yaml
# ABOUTME: Pre-commit configuration for Node.js projects
# Enforces code quality standards
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
        args: ['--maxkb=5000']
      - id: check-json
      - id: check-merge-conflict

  - repo: https://github.com/pre-commit/mirrors-eslint
    rev: v8.56.0
    hooks:
      - id: eslint
        files: \.(js|jsx|ts|tsx)$
        types: [file]
        additional_dependencies:
          - eslint@8.56.0
          - eslint-config-prettier@9.1.0
          - eslint-plugin-react@7.33.2
          - eslint-plugin-react-hooks@4.6.0

  - repo: https://github.com/pre-commit/mirrors-prettier
    rev: v3.1.0
    hooks:
      - id: prettier
        files: \.(js|jsx|ts|tsx|json|css|scss|md)$

  - repo: local
    hooks:
      - id: npm-test
        name: npm test
        entry: npm test
        language: system
        pass_filenames: false
        always_run: true
```

## Commit Message Standards

### Conventional Commits
```
<type>(<scope>): <subject>

<body>

<footer>
```

Types:
- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, etc.)
- **refactor**: Code refactoring
- **test**: Test additions or modifications
- **chore**: Build process or auxiliary tool changes
- **perf**: Performance improvements

### Examples
```bash
feat(contacts): add bulk import functionality

- Add CSV import capability
- Support multiple data formats
- Include validation and error handling

Closes #123

---

fix(api): handle rate limiting correctly

Previously, the API would crash when rate limited.
Now it implements exponential backoff.

---

test(auth): add integration tests for JWT

- Test token generation
- Test token validation
- Test token expiration
```

## Git Aliases for Bray.Doc

Add these to your `.gitconfig`:

```ini
[alias]
    # Quick commits with conventional format
    cm = "!f() { git commit -m \"$1: $2\" -m \"$3\"; }; f"
    
    # Example: git cm feat "add new feature" "Extended description"
    
    # Status with branch info
    st = status -sb
    
    # Pretty log
    lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
    
    # Show files changed in last commit
    last = log -1 HEAD --stat
    
    # Undo last commit (keep changes)
    undo = reset HEAD~1 --mixed
    
    # Amend without editing message
    amend = commit --amend --no-edit
    
    # List branches sorted by last modified
    branches = branch --sort=-committerdate
    
    # Stash with message
    stash-save = "!f() { git stash save \"$1\"; }; f"
    
    # Interactive rebase
    rb = "!f() { git rebase -i HEAD~$1; }; f"
```

## Branch Protection Rules

For main/master branches:

1. **Require pull request reviews** before merging
2. **Require status checks** to pass:
   - All tests must pass
   - Linting must pass
   - Build must succeed
3. **Require branches to be up to date** before merging
4. **Include administrators** in restrictions
5. **Prevent force pushes** and deletions

## Git Hooks Installation Script

Create `scripts/install-hooks.sh`:

```bash
#!/usr/bin/env bash
# ABOUTME: Install git hooks for the project
# Sets up pre-commit and other git hooks

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "Installing git hooks for $REPO_ROOT..."

# Install pre-commit hook
if [ -f "$REPO_ROOT/.pre-commit-config.yaml" ]; then
    echo "Installing pre-commit framework..."
    pip install pre-commit
    pre-commit install
    pre-commit install --hook-type commit-msg
else
    echo "Installing custom pre-commit hook..."
    cp "$SCRIPT_DIR/pre-commit.sh" "$REPO_ROOT/.git/hooks/pre-commit"
    chmod +x "$REPO_ROOT/.git/hooks/pre-commit"
fi

# Install commit-msg hook for conventional commits
cat > "$REPO_ROOT/.git/hooks/commit-msg" << 'EOF'
#!/usr/bin/env bash
# ABOUTME: Validate commit message format
# Ensures conventional commit format

commit_regex='^(feat|fix|docs|style|refactor|test|chore|perf)(\(.+\))?: .{1,50}'

if ! grep -qE "$commit_regex" "$1"; then
    echo "Invalid commit message format!"
    echo "Format: <type>(<scope>): <subject>"
    echo "Example: feat(api): add user authentication"
    echo ""
    echo "Types: feat, fix, docs, style, refactor, test, chore, perf"
    exit 1
fi
EOF

chmod +x "$REPO_ROOT/.git/hooks/commit-msg"

echo "Git hooks installed successfully!"
```

## CI/CD Integration

### GitHub Actions Example
```yaml
name: Pre-commit

on: [push, pull_request]

jobs:
  pre-commit:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    - uses: pre-commit/action@v3.0.0
```

## Summary

This git workflow ensures:
1. **Code quality** through automated pre-commit checks
2. **Security** by scanning for sensitive data
3. **Consistency** through formatting and linting
4. **Standards** via conventional commit messages
5. **Safety** through branch protection rules

The setup works globally across all projects while allowing project-specific customization.