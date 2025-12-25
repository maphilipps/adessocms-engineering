#!/bin/bash

# ============================================
# BD-Audit: Deploy Script
# Builds and deploys VitePress reports to Netlify
# ============================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPORTS_DIR="${BD_AUDIT_REPORTS_DIR:-$HOME/Sites/bd-audit-reports}"
NETLIFY_SITE_ID="${NETLIFY_SITE_ID:-}"
NETLIFY_AUTH_TOKEN="${NETLIFY_AUTH_TOKEN:-}"

# Usage
usage() {
    echo -e "${BLUE}BD-Audit: Deploy Script${NC}"
    echo ""
    echo "Usage: $0 [customer-slug] [options]"
    echo ""
    echo "Arguments:"
    echo "  customer-slug   Deploy specific customer (optional, deploys all if omitted)"
    echo ""
    echo "Options:"
    echo "  --prod          Deploy to production"
    echo "  --preview       Deploy preview only (default)"
    echo "  --help          Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                    # Build and preview all"
    echo "  $0 acme-corp          # Build and preview acme-corp"
    echo "  $0 acme-corp --prod   # Deploy acme-corp to production"
    echo ""
    exit 1
}

# Parse arguments
CUSTOMER_SLUG=""
DEPLOY_PROD=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --prod)
            DEPLOY_PROD=true
            shift
            ;;
        --preview)
            DEPLOY_PROD=false
            shift
            ;;
        --help)
            usage
            ;;
        -*)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            ;;
        *)
            CUSTOMER_SLUG="$1"
            shift
            ;;
    esac
done

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║        BD-Audit: Deploy Script         ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Check reports directory
if [ ! -d "$REPORTS_DIR" ]; then
    echo -e "${RED}Error: Reports directory not found: $REPORTS_DIR${NC}"
    echo "Set BD_AUDIT_REPORTS_DIR environment variable or clone the repository."
    exit 1
fi

cd "$REPORTS_DIR"

# Function to build a customer report
build_customer() {
    local slug=$1
    local dir="$REPORTS_DIR/customers/$slug"

    if [ ! -d "$dir" ]; then
        echo -e "${RED}Error: Customer '$slug' not found${NC}"
        return 1
    fi

    echo -e "${YELLOW}Building: $slug${NC}"

    cd "$dir"

    # Install dependencies if needed
    if [ ! -d "node_modules" ]; then
        echo -e "  Installing dependencies..."
        npm install --silent
    fi

    # Build
    echo -e "  Building VitePress..."
    npm run build --silent

    if [ -d ".vitepress/dist" ]; then
        echo -e "  ${GREEN}✓ Build successful${NC}"
        return 0
    else
        echo -e "  ${RED}✗ Build failed${NC}"
        return 1
    fi
}

# Function to deploy a customer report
deploy_customer() {
    local slug=$1
    local dir="$REPORTS_DIR/customers/$slug"

    if [ ! -d "$dir/.vitepress/dist" ]; then
        echo -e "${RED}Error: Build not found for '$slug'. Run build first.${NC}"
        return 1
    fi

    echo -e "${YELLOW}Deploying: $slug${NC}"

    cd "$dir"

    # Check for Netlify CLI
    if ! command -v netlify &> /dev/null; then
        echo -e "${RED}Error: Netlify CLI not installed.${NC}"
        echo "Install with: npm install -g netlify-cli"
        return 1
    fi

    # Deploy
    if [ "$DEPLOY_PROD" = true ]; then
        echo -e "  Deploying to ${GREEN}production${NC}..."
        netlify deploy --prod --dir=.vitepress/dist --site="$NETLIFY_SITE_ID"
    else
        echo -e "  Deploying ${YELLOW}preview${NC}..."
        netlify deploy --dir=.vitepress/dist --site="$NETLIFY_SITE_ID"
    fi

    echo -e "  ${GREEN}✓ Deploy successful${NC}"
}

# Build and deploy
if [ -n "$CUSTOMER_SLUG" ]; then
    # Single customer
    build_customer "$CUSTOMER_SLUG"
    deploy_customer "$CUSTOMER_SLUG"
else
    # All customers
    echo -e "${YELLOW}Building all customers...${NC}"
    echo ""

    for dir in "$REPORTS_DIR/customers"/*/; do
        if [ -d "$dir" ]; then
            slug=$(basename "$dir")
            build_customer "$slug" || true
        fi
    done

    echo ""
    echo -e "${GREEN}All builds complete!${NC}"

    if [ "$DEPLOY_PROD" = true ]; then
        echo ""
        echo -e "${YELLOW}Deploying all to production...${NC}"

        for dir in "$REPORTS_DIR/customers"/*/; do
            if [ -d "$dir/.vitepress/dist" ]; then
                slug=$(basename "$dir")
                deploy_customer "$slug" || true
            fi
        done
    fi
fi

echo ""
echo -e "${GREEN}Done!${NC}"
