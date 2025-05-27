#!/usr/bin/env bash
# ABOUTME: Install global git hooks
# Sets up pre-commit hooks across all projects

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CLAUDE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "Installing Bray.Doc's global git hooks..."

# Create git templates directory
mkdir -p ~/.git-templates/hooks

# Create the global pre-commit hook
cat > ~/.git-templates/hooks/pre-commit << 'EOF'
#!/usr/bin/env bash
# ABOUTME: Global pre-commit hook for Bray.Doc
# Runs project-specific quality checks

set -e

# Get repository root
REPO_ROOT=$(git rev-parse --show-toplevel)
cd "$REPO_ROOT"

echo "Running pre-commit checks..."

# Check if .pre-commit-config.yaml exists
if [ -f ".pre-commit-config.yaml" ]; then
    # Use pre-commit framework
    if command -v pre-commit &> /dev/null; then
        PRE_COMMIT_ALLOW_NO_CONFIG=1 pre-commit run --stage pre-commit
    else
        echo "WARNING: pre-commit framework not installed"
        echo "Install with: pip install pre-commit"
    fi
else
    # Run project-specific checks
    if [ -f "scripts/pre-commit.sh" ]; then
        ./scripts/pre-commit.sh
    else
        # Default checks based on project type
        
        # Python projects
        if [ -f "requirements.txt" ] || [ -f "pyproject.toml" ] || [ -f "setup.py" ]; then
            echo "Running Python checks..."
            
            # Check for syntax errors
            if command -v python3 &> /dev/null; then
                find . -name "*.py" -not -path "./venv/*" -not -path "./.venv/*" -not -path "./env/*" | xargs python3 -m py_compile 2>/dev/null || true
            fi
            
            # Run black in check mode
            if command -v black &> /dev/null; then
                black --check . 2>/dev/null || echo "WARNING: Black formatting issues found"
            fi
            
            # Check for debug statements
            if grep -r "import pdb\|pdb.set_trace()" --include="*.py" . 2>/dev/null; then
                echo "ERROR: Found pdb imports or set_trace() calls"
                exit 1
            fi
        fi
        
        # Node.js projects
        if [ -f "package.json" ]; then
            echo "Running Node.js checks..."
            
            # Run linting if available
            if grep -q "\"lint\":" package.json; then
                npm run lint || echo "WARNING: Linting issues found"
            fi
            
            # Check for console.log in production code
            if [ -d "src" ]; then
                if grep -r "console\.log" --include="*.js" --include="*.ts" --include="*.jsx" --include="*.tsx" --exclude-dir=node_modules --exclude-dir=tests --exclude-dir=__tests__ src/ 2>/dev/null; then
                    echo "WARNING: Found console.log statements in src/"
                fi
            fi
        fi
    fi
fi

# Check for sensitive data
echo "Checking for sensitive data..."

# Common patterns that might indicate secrets
PATTERNS=(
    "api_key"
    "apikey"
    "api-key"
    "password"
    "passwd"
    "pwd"
    "secret"
    "token"
    "PRIVATE KEY"
    "Bearer [A-Za-z0-9]"
    "AWS[A-Z0-9]{16}"
)

for pattern in "${PATTERNS[@]}"; do
    if git diff --cached --name-only | xargs grep -i "$pattern" 2>/dev/null | grep -v "example\|dummy\|fake\|test\|mock" | head -5; then
        echo ""
        echo "⚠️  WARNING: Possible sensitive data detected!"
        echo "Please review your staged changes: git diff --cached"
        read -p "Continue with commit? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
        break
    fi
done

# Check file size (cross-platform)
for file in $(git diff --cached --name-only); do
    if [ -f "$file" ]; then
        # Try macOS stat first, fall back to Linux
        size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo "0")
        if [ "$size" -gt 5242880 ]; then  # 5MB
            echo "ERROR: $file is larger than 5MB"
            echo "Consider using Git LFS for large files"
            exit 1
        fi
    fi
done

echo "✅ Pre-commit checks passed!"
EOF

# Create commit-msg hook for conventional commits
cat > ~/.git-templates/hooks/commit-msg << 'EOF'
#!/usr/bin/env bash
# ABOUTME: Validate commit message format
# Ensures conventional commit format

commit_regex='^(feat|fix|docs|style|refactor|test|chore|perf|build|ci|revert)(\(.+\))?: .{1,72}'

# Get the commit message
commit_message=$(cat "$1")

# Skip merge commits
if echo "$commit_message" | grep -q "^Merge"; then
    exit 0
fi

# Check format
if ! echo "$commit_message" | grep -qE "$commit_regex"; then
    echo "❌ Invalid commit message format!"
    echo ""
    echo "Format: <type>(<scope>): <subject>"
    echo ""
    echo "Types:"
    echo "  feat     - New feature"
    echo "  fix      - Bug fix"
    echo "  docs     - Documentation changes"
    echo "  style    - Code style changes"
    echo "  refactor - Code refactoring"
    echo "  test     - Test changes"
    echo "  chore    - Build/auxiliary changes"
    echo "  perf     - Performance improvements"
    echo "  build    - Build system changes"
    echo "  ci       - CI/CD changes"
    echo "  revert   - Revert previous commit"
    echo ""
    echo "Examples:"
    echo "  feat(api): add user authentication"
    echo "  fix(contacts): resolve duplicate entry bug"
    echo "  docs: update installation guide"
    echo ""
    echo "Your message: $commit_message"
    exit 1
fi

# Warn if subject is too short
subject=$(echo "$commit_message" | sed 's/^[^:]*: //')
if [ ${#subject} -lt 10 ]; then
    echo "⚠️  Warning: Commit subject seems too short (${#subject} chars)"
    echo "Consider adding more detail to the subject line"
fi
EOF

# Make hooks executable
chmod +x ~/.git-templates/hooks/pre-commit
chmod +x ~/.git-templates/hooks/commit-msg

# Set as global template directory
git config --global init.templateDir ~/.git-templates

echo "✅ Global git hooks installed!"
echo ""
echo "To add hooks to existing repositories, run:"
echo "  cp ~/.git-templates/hooks/* .git/hooks/"
echo ""
echo "New repositories will automatically get these hooks."
echo ""
echo "To disable hooks temporarily, use:"
echo "  git commit --no-verify"