#!/bin/bash
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Installation Verification                                 ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

FAILED=0
WARNINGS=0

check_command() {
    local cmd=$1
    local name=${2:-$cmd}
    
    if command -v "$cmd" &> /dev/null; then
        local version=$($cmd --version 2>&1 | head -n1 || echo "installed")
        echo -e "${GREEN}✓${NC} $name: $version"
        return 0
    else
        echo -e "${RED}✗${NC} $name: not found"
        ((FAILED++))
        return 1
    fi
}

check_optional() {
    local cmd=$1
    local name=${2:-$cmd}
    
    if command -v "$cmd" &> /dev/null; then
        echo -e "${GREEN}✓${NC} $name: installed"
        return 0
    else
        echo -e "${YELLOW}⚠${NC} $name: not installed (optional)"
        ((WARNINGS++))
        return 1
    fi
}

echo -e "${BLUE}Base System:${NC}"
check_command "git" "Git"
check_command "curl" "curl"
check_command "wget" "wget"
check_command "jq" "jq"

echo ""
echo -e "${BLUE}Package Managers:${NC}"
check_command "npm" "npm"
check_command "node" "Node.js"
check_optional "bun" "Bun"
check_command "cargo" "Rust/Cargo"
check_command "uv" "uv"

echo ""
echo -e "${BLUE}Modern CLI Tools:${NC}"
check_command "eza" "eza"
check_command "bat" "bat"
check_command "rg" "ripgrep"
check_command "fd" "fd"
check_command "zoxide" "zoxide"
check_optional "fzf" "fzf"
check_optional "delta" "git-delta"
check_optional "lazygit" "lazygit"
check_optional "gh" "GitHub CLI"
check_optional "btop" "btop"
check_optional "procs" "procs"
check_optional "starship" "starship"

echo ""
echo -e "${BLUE}OpenCode Ecosystem:${NC}"
check_command "opencode" "OpenCode CLI"

if [ -d "$HOME/.config/opencode/superpowers" ]; then
    echo -e "${GREEN}✓${NC} Superpowers skills: installed"
else
    echo -e "${YELLOW}⚠${NC} Superpowers skills: not found"
    ((WARNINGS++))
fi

echo ""
echo -e "${BLUE}AI Frameworks:${NC}"
python3 -c "import langchain" 2>/dev/null && echo -e "${GREEN}✓${NC} LangChain: installed" || echo -e "${YELLOW}⚠${NC} LangChain: not installed"
python3 -c "import crewai" 2>/dev/null && echo -e "${GREEN}✓${NC} CrewAI: installed" || echo -e "${YELLOW}⚠${NC} CrewAI: not installed"
python3 -c "import litellm" 2>/dev/null && echo -e "${GREEN}✓${NC} LiteLLM: installed" || echo -e "${YELLOW}⚠${NC} LiteLLM: not installed"
check_optional "ollama" "Ollama"

echo ""
echo -e "${BLUE}DevOps Tools (Optional):${NC}"
check_optional "docker" "Docker"
check_optional "docker-compose" "Docker Compose"
check_optional "kubectl" "kubectl"
check_optional "terraform" "Terraform"
check_optional "ansible" "Ansible"

echo ""
echo -e "${BLUE}Configuration Files:${NC}"

CONFIG_DIR="$HOME/.config/opencode"
if [ -f "$CONFIG_DIR/.env" ]; then
    echo -e "${GREEN}✓${NC} Environment file: $CONFIG_DIR/.env"
else
    echo -e "${YELLOW}⚠${NC} Environment file: not found (run setup-wizard.sh)"
    ((WARNINGS++))
fi

if [ -f "$CONFIG_DIR/opencode.json" ]; then
    echo -e "${GREEN}✓${NC} OpenCode config: $CONFIG_DIR/opencode.json"
else
    echo -e "${RED}✗${NC} OpenCode config: not found"
    ((FAILED++))
fi

if [ -f "$CONFIG_DIR/manifest.json" ]; then
    echo -e "${GREEN}✓${NC} Installation manifest: $CONFIG_DIR/manifest.json"
else
    echo -e "${YELLOW}⚠${NC} Installation manifest: not found"
    ((WARNINGS++))
fi

echo ""
echo -e "${BLUE}Shell Configuration:${NC}"

SHELL_RC="$HOME/.bashrc"
if [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="$HOME/.zshrc"
fi

if grep -q "Modern CLI aliases" "$SHELL_RC" 2>/dev/null; then
    echo -e "${GREEN}✓${NC} CLI aliases configured"
else
    echo -e "${YELLOW}⚠${NC} CLI aliases not configured"
    ((WARNINGS++))
fi

if grep -q "zoxide init" "$SHELL_RC" 2>/dev/null; then
    echo -e "${GREEN}✓${NC} zoxide initialized"
else
    echo -e "${YELLOW}⚠${NC} zoxide not initialized"
    ((WARNINGS++))
fi

if grep -q "starship init" "$SHELL_RC" 2>/dev/null; then
    echo -e "${GREEN}✓${NC} starship initialized"
else
    echo -e "${YELLOW}⚠${NC} starship not initialized"
    ((WARNINGS++))
fi

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Verification Summary                                      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

if [ $FAILED -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo ""
    echo -e "${YELLOW}Next Steps:${NC}"
    echo "  1. Restart your terminal: source ~/.bashrc"
    echo "  2. Test OpenCode: opencode --version"
    echo "  3. Configure API keys: nano $CONFIG_DIR/.env"
    echo "  4. Start coding: opencode"
    exit 0
elif [ $FAILED -eq 0 ]; then
    echo -e "${YELLOW}⚠ Installation complete with $WARNINGS warnings${NC}"
    echo ""
    echo -e "${YELLOW}Optional components not installed. Installation is functional.${NC}"
    exit 0
else
    echo -e "${RED}✗ Installation incomplete: $FAILED critical components missing${NC}"
    echo -e "${YELLOW}⚠ Warnings: $WARNINGS${NC}"
    echo ""
    echo -e "${YELLOW}Please review the errors above and re-run the installation.${NC}"
    exit 1
fi
