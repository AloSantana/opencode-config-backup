#!/bin/bash
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Installing Modern CLI Tools...${NC}"
echo ""

install_rust_tool() {
    local tool=$1
    local package=${2:-$tool}
    
    if command -v "$tool" &> /dev/null; then
        echo -e "${GREEN}✓ $tool already installed${NC}"
    else
        echo -e "${YELLOW}→ Installing $tool...${NC}"
        cargo install "$package" || echo -e "${YELLOW}⚠ Failed to install $tool${NC}"
    fi
}

if ! command -v cargo &> /dev/null; then
    echo -e "${YELLOW}→ Installing Rust...${NC}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    echo -e "${GREEN}✓ Rust installed${NC}"
fi

echo -e "${BLUE}File & Directory Navigation:${NC}"
install_rust_tool "eza"
install_rust_tool "fd" "fd-find"
install_rust_tool "zoxide"

echo ""
echo -e "${BLUE}File Viewing & Search:${NC}"
install_rust_tool "bat"
install_rust_tool "rg" "ripgrep"

if ! command -v fzf &> /dev/null; then
    echo -e "${YELLOW}→ Installing fzf...${NC}"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
    echo -e "${GREEN}✓ fzf installed${NC}"
else
    echo -e "${GREEN}✓ fzf already installed${NC}"
fi

echo ""
echo -e "${BLUE}Git Tools:${NC}"
install_rust_tool "delta" "git-delta"

if ! command -v lazygit &> /dev/null; then
    echo -e "${YELLOW}→ Installing lazygit...${NC}"
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit lazygit.tar.gz
    echo -e "${GREEN}✓ lazygit installed${NC}"
else
    echo -e "${GREEN}✓ lazygit already installed${NC}"
fi

if ! command -v gh &> /dev/null; then
    echo -e "${YELLOW}→ Installing GitHub CLI...${NC}"
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install -y gh
    echo -e "${GREEN}✓ GitHub CLI installed${NC}"
else
    echo -e "${GREEN}✓ GitHub CLI already installed${NC}"
fi

echo ""
echo -e "${BLUE}Process Monitoring:${NC}"
install_rust_tool "procs"

if ! command -v btop &> /dev/null; then
    echo -e "${YELLOW}→ Installing btop...${NC}"
    sudo apt install -y btop || sudo snap install btop || echo -e "${YELLOW}⚠ Failed to install btop${NC}"
    echo -e "${GREEN}✓ btop installed${NC}"
else
    echo -e "${GREEN}✓ btop already installed${NC}"
fi

echo ""
echo -e "${BLUE}JSON/YAML Tools:${NC}"

if ! command -v jq &> /dev/null; then
    echo -e "${YELLOW}→ Installing jq...${NC}"
    sudo apt install -y jq
    echo -e "${GREEN}✓ jq installed${NC}"
else
    echo -e "${GREEN}✓ jq already installed${NC}"
fi

if ! command -v yq &> /dev/null; then
    echo -e "${YELLOW}→ Installing yq...${NC}"
    sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq
    sudo chmod +x /usr/local/bin/yq
    echo -e "${GREEN}✓ yq installed${NC}"
else
    echo -e "${GREEN}✓ yq already installed${NC}"
fi

if command -v npm &> /dev/null; then
    if ! command -v fx &> /dev/null; then
        echo -e "${YELLOW}→ Installing fx...${NC}"
        npm install -g fx
        echo -e "${GREEN}✓ fx installed${NC}"
    else
        echo -e "${GREEN}✓ fx already installed${NC}"
    fi
fi

echo ""
echo -e "${BLUE}API Testing:${NC}"
install_rust_tool "xh"

if ! command -v httpie &> /dev/null; then
    echo -e "${YELLOW}→ Installing httpie...${NC}"
    sudo apt install -y httpie || pip install httpie
    echo -e "${GREEN}✓ httpie installed${NC}"
else
    echo -e "${GREEN}✓ httpie already installed${NC}"
fi

echo ""
echo -e "${BLUE}Terminal Multiplexers:${NC}"

if ! command -v tmux &> /dev/null; then
    echo -e "${YELLOW}→ Installing tmux...${NC}"
    sudo apt install -y tmux
    echo -e "${GREEN}✓ tmux installed${NC}"
else
    echo -e "${GREEN}✓ tmux already installed${NC}"
fi

install_rust_tool "zellij"

echo ""
echo -e "${BLUE}Shell Enhancements:${NC}"
install_rust_tool "starship"

echo ""
echo -e "${BLUE}Setting up shell aliases...${NC}"

SHELL_RC="$HOME/.bashrc"
if [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="$HOME/.zshrc"
fi

if ! grep -q "Modern CLI aliases" "$SHELL_RC"; then
    cat >> "$SHELL_RC" << 'EOF'

# Modern CLI aliases
alias ls='eza --icons'
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias tree='eza --tree --icons'
alias cat='bat'
alias find='fd'
alias grep='rg'
alias ps='procs'

# Git aliases
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias lg='lazygit'

# Initialize tools
eval "$(zoxide init bash)"
eval "$(starship init bash)"
EOF
    echo -e "${GREEN}✓ Shell aliases configured${NC}"
else
    echo -e "${GREEN}✓ Shell aliases already configured${NC}"
fi

echo ""
echo -e "${GREEN}Modern CLI tools installation complete!${NC}"
