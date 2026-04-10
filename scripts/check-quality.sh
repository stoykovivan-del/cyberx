#!/bin/bash
# Automated Code Quality Check Script
# Run this script in CI or locally before committing

set -e

echo "=== Running Code Quality Checks ==="

# 1. Check for linting errors
echo ""
echo "[1/4] Running ESLint..."
if command -v npx &> /dev/null; then
  npx eslint . --ext .ts,.tsx --max-warnings=0 || {
    echo "ESLint failed. Run 'npx eslint . --fix' to auto-fix issues."
    exit 1
  }
else
  echo "ESLint not installed. Skipping."
fi

# 2. Check formatting
echo ""
echo "[2/4] Checking code formatting..."
if command -v npx &> /dev/null; then
  npx prettier --check "**/*.{ts,tsx,js,jsx,json,md}" || {
    echo "Prettier check failed. Run 'npx prettier --write .' to fix."
    exit 1
  }
else
  echo "Prettier not installed. Skipping."
fi

# 3. Run tests
echo ""
echo "[3/4] Running tests..."
if [ -f "package.json" ] && grep -q '"test"' package.json; then
  npm test || {
    echo "Tests failed."
    exit 1
  }
else
  echo "No test script found. Skipping."
fi

# 4. Type checking
echo ""
echo "[4/4] Running TypeScript type check..."
if command -v npx &> /dev/null && [ -f "tsconfig.json" ]; then
  npx tsc --noEmit || {
    echo "TypeScript type check failed."
    exit 1
  }
else
  echo "TypeScript not configured. Skipping."
fi

echo ""
echo "=== All checks passed! ==="
exit 0
