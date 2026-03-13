#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration file
CONFIG_DIR="$HOME/.config/opencode"
ENV_FILE="$CONFIG_DIR/.env"
MANIFEST_FILE="$CONFIG_DIR/manifest.json"

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  OpenCode & AI Development Environment Setup Wizard       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Function to prompt for input with default
prompt_with_default() {
    local prompt="$1"
    local default="$2"
    local var_name="$3"
    
    if [ -n "$default" ]; then
        read -p "$(echo -e ${YELLOW}$prompt ${NC}[${GREEN}$default${NC}]): " input
        eval "$var_name=\"${input:-$default}\""
    else
        read -p "$(echo -e ${YELLOW}$prompt${NC}): " input
        eval "$var_name=\"$input\""
    fi
}

# Function to prompt yes/no
prompt_yes_no() {
    local prompt="$1"
    local default="$2"
    
    if [ "$default" = "y" ]; then
        read -p "$(echo -e ${YELLOW}$prompt${NC} [${GREEN}Y${NC}/n]): " response
        response="${response:-y}"
    else
        read -p "$(echo -e ${YELLOW}$prompt${NC} [y/${GREEN}N${NC}]): " response
        response="${response:-n}"
    fi
    
    [[ "$response" =~ ^[Yy]$ ]]
}

# Create config directory if it doesn't exist
mkdir -p "$CONFIG_DIR"

echo -e "${GREEN}Step 1: Installation Components${NC}"
echo "Select which components to install:"
echo ""

prompt_yes_no "Install base system packages (git, curl, build-essential)?" "y" && INSTALL_BASE=true || INSTALL_BASE=false
prompt_yes_no "Install modern CLI tools (eza, bat, ripgrep, fd, etc.)?" "y" && INSTALL_CLI=true || INSTALL_CLI=false
prompt_yes_no "Install DevOps tools (Docker, Kubernetes, Terraform)?" "n" && INSTALL_DEVOPS=true || INSTALL_DEVOPS=false
prompt_yes_no "Install AI frameworks (LangChain, CrewAI, LiteLLM)?" "y" && INSTALL_AI=true || INSTALL_AI=false
prompt_yes_no "Install OpenCode ecosystem (Oh My OpenCode, MCP servers)?" "y" && INSTALL_OPENCODE=true || INSTALL_OPENCODE=false
prompt_yes_no "Install Android remote access tools?" "n" && INSTALL_ANDROID=true || INSTALL_ANDROID=false

echo ""
echo -e "${GREEN}Step 2: API Keys Configuration${NC}"
echo "Configure API keys for various services (leave blank to skip):"
echo ""

# GitHub
prompt_with_default "GitHub Personal Access Token" "" "GITHUB_TOKEN"

# Search APIs
echo ""
echo -e "${BLUE}Search APIs:${NC}"
prompt_with_default "Tavily API Key" "" "TAVILY_API_KEY"
prompt_with_default "Exa API Key" "" "EXA_API_KEY"
prompt_with_default "Brave Search API Key" "" "BRAVE_API_KEY"
prompt_with_default "Context7 API Key" "" "CONTEXT7_API_KEY"

# AI Services
echo ""
echo -e "${BLUE}AI Services:${NC}"
prompt_with_default "Anthropic API Key" "" "ANTHROPIC_API_KEY"
prompt_with_default "OpenAI API Key" "" "OPENAI_API_KEY"
prompt_with_default "Gemini API Key" "" "GEMINI_API_KEY"
prompt_with_default "OpenRouter API Key" "" "OPENROUTER_API_KEY"

# Databases
echo ""
echo -e "${BLUE}Databases (optional):${NC}"
prompt_with_default "PostgreSQL Connection String" "" "POSTGRES_CONNECTION_STRING"
prompt_with_default "Qdrant URL" "" "QDRANT_URL"
prompt_with_default "Qdrant API Key" "" "QDRANT_API_KEY"

# Productivity
echo ""
echo -e "${BLUE}Productivity Tools (optional):${NC}"
prompt_with_default "Linear API Key" "" "LINEAR_API_KEY"
prompt_with_default "Notion API Key" "" "NOTION_API_KEY"

# Web Scraping
echo ""
echo -e "${BLUE}Web Scraping (optional):${NC}"
prompt_with_default "Firecrawl API Key" "" "FIRECRAWL_API_KEY"

echo ""
echo -e "${GREEN}Step 3: Model Configuration${NC}"
echo "Configure default AI models:"
echo ""

prompt_with_default "Default model provider" "anthropic" "DEFAULT_PROVIDER"
prompt_with_default "Default model" "claude-sonnet-4" "DEFAULT_MODEL"
prompt_with_default "Enable model routing (9router)?" "y" "ENABLE_ROUTING"

echo ""
echo -e "${GREEN}Step 4: Shell Configuration${NC}"
echo ""

prompt_with_default "Default shell" "bash" "DEFAULT_SHELL"
prompt_yes_no "Install Starship prompt?" "y" && INSTALL_STARSHIP=true || INSTALL_STARSHIP=false
prompt_yes_no "Install zoxide (smart cd)?" "y" && INSTALL_ZOXIDE=true || INSTALL_ZOXIDE=false

echo ""
echo -e "${YELLOW}═══════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}Configuration Summary${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo "Installation Components:"
echo "  Base System: $INSTALL_BASE"
echo "  CLI Tools: $INSTALL_CLI"
echo "  DevOps: $INSTALL_DEVOPS"
echo "  AI Frameworks: $INSTALL_AI"
echo "  OpenCode: $INSTALL_OPENCODE"
echo "  Android Tools: $INSTALL_ANDROID"
echo ""
echo "Configuration:"
echo "  Default Provider: $DEFAULT_PROVIDER"
echo "  Default Model: $DEFAULT_MODEL"
echo "  Shell: $DEFAULT_SHELL"
echo ""

if ! prompt_yes_no "Proceed with installation?" "y"; then
    echo -e "${RED}Installation cancelled.${NC}"
    exit 0
fi

echo ""
echo -e "${GREEN}Generating configuration files...${NC}"

# Generate .env file
cat > "$ENV_FILE" << EOF
# Generated by setup-wizard.sh on $(date)

# GitHub
export GITHUB_TOKEN="$GITHUB_TOKEN"

# Search APIs
export TAVILY_API_KEY="$TAVILY_API_KEY"
export EXA_API_KEY="$EXA_API_KEY"
export BRAVE_API_KEY="$BRAVE_API_KEY"
export CONTEXT7_API_KEY="$CONTEXT7_API_KEY"

# AI Services
export ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY"
export OPENAI_API_KEY="$OPENAI_API_KEY"
export GEMINI_API_KEY="$GEMINI_API_KEY"
export OPENROUTER_API_KEY="$OPENROUTER_API_KEY"

# Databases
export POSTGRES_CONNECTION_STRING="$POSTGRES_CONNECTION_STRING"
export QDRANT_URL="$QDRANT_URL"
export QDRANT_API_KEY="$QDRANT_API_KEY"

# Productivity
export LINEAR_API_KEY="$LINEAR_API_KEY"
export NOTION_API_KEY="$NOTION_API_KEY"

# Web Scraping
export FIRECRAWL_API_KEY="$FIRECRAWL_API_KEY"

# Model Configuration
export DEFAULT_PROVIDER="$DEFAULT_PROVIDER"
export DEFAULT_MODEL="$DEFAULT_MODEL"
EOF

echo -e "${GREEN}✓ Created $ENV_FILE${NC}"

# Generate manifest.json
cat > "$MANIFEST_FILE" << EOF
{
  "version": "1.0.0",
  "generated": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "components": {
    "base": $INSTALL_BASE,
    "cli": $INSTALL_CLI,
    "devops": $INSTALL_DEVOPS,
    "ai": $INSTALL_AI,
    "opencode": $INSTALL_OPENCODE,
    "android": $INSTALL_ANDROID
  },
  "configuration": {
    "provider": "$DEFAULT_PROVIDER",
    "model": "$DEFAULT_MODEL",
    "shell": "$DEFAULT_SHELL",
    "starship": $INSTALL_STARSHIP,
    "zoxide": $INSTALL_ZOXIDE
  }
}
EOF

echo -e "${GREEN}✓ Created $MANIFEST_FILE${NC}"

# Save installation flags for install-all.sh
export INSTALL_BASE INSTALL_CLI INSTALL_DEVOPS INSTALL_AI INSTALL_OPENCODE INSTALL_ANDROID
export INSTALL_STARSHIP INSTALL_ZOXIDE

echo ""
echo -e "${GREEN}Configuration complete!${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Review configuration: cat $ENV_FILE"
echo "  2. Run installation: ./install-all.sh"
echo "  3. Restart your shell or run: source ~/.${DEFAULT_SHELL}rc"
echo ""
