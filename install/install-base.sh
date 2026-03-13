#!/bin/bash
set -e

# OpenCode Server Setup Hub - Base System Installation
# Installs: Package managers (uv, fnm, mise, rustup) and base system tools
# Version: 1.0.0
# Last Updated: 2026-03-13

# ============================================
# Configuration
# ============================================
LOG_FILE="$HOME/.opencode-setup.log"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# ============================================
# Logging Functions
# ============================================
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log_info() {
    echo -e "${BLUE}ℹ${NC} $1" | tee -a "$LOG_FILE"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1" | tee -a "$LOG_FILE"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1" | tee -a "$LOG_FILE"
}

log_error() {
    echo -e "${RED}✗${NC} $1" | tee -a "$LOG_FILE"
}

# ============================================
# OS Detection
# ============================================
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
        if [ -f /etc/debian_version ]; then
            DISTRO="debian"
        elif [ -f /etc/redhat-release ]; then
            DISTRO="redhat"
        else
            DISTRO="unknown"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        DISTRO="macos"
    else
        OS="unknown"
        DISTRO="unknown"
    fi
    
    log_info "Detected OS: $OS ($DISTRO)"
}

# ============================================
# Utility Functions
# ============================================
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# ============================================
# Installation Functions
# ============================================

install_base_packages() {
    log_info "Installing base system packages..."
    
    if [[ "$DISTRO" == "debian" ]]; then
        sudo apt update
        sudo apt install -y build-essential curl wget git vim unzip
        log_success "Base packages installed"
    elif [[ "$OS" == "macos" ]]; then
        if ! command_exists brew; then
            log_info "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            log_success "Homebrew installed"
        fi
        brew install curl wget git vim
        log_success "Base packages installed"
    fi
}

install_uv() {
    log_info "Installing uv (Python package manager)..."
    
    if command_exists uv; then
        log_success "uv already installed ($(uv --version))"
        return 0
    fi
    
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
    
    if command_exists uv; then
        log_success "uv installed ($(uv --version))"
    else
        log_error "uv installation failed"
        return 1
    fi
}

install_fnm() {
    log_info "Installing fnm (Fast Node Manager)..."
    
    if command_exists fnm; then
        log_success "fnm already installed ($(fnm --version))"
        return 0
    fi
    
    curl -fsSL https://fnm.vercel.app/install | bash
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env --use-on-cd)"
    
    if command_exists fnm; then
        log_success "fnm installed ($(fnm --version))"
        
        # Install latest LTS Node.js
        log_info "Installing Node.js LTS..."
        fnm install --lts
        fnm use lts-latest
        log_success "Node.js installed ($(node --version))"
    else
        log_error "fnm installation failed"
        return 1
    fi
}

install_mise() {
    log_info "Installing mise (Universal runtime manager)..."
    
    if command_exists mise; then
        log_success "mise already installed ($(mise --version))"
        return 0
    fi
    
    curl https://mise.jdx.dev/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
    
    if command_exists mise; then
        log_success "mise installed ($(mise --version))"
    else
        log_error "mise installation failed"
        return 1
    fi
}

install_rustup() {
    log_info "Installing Rust (rustup)..."
    
    if command_exists cargo; then
        log_success "Rust already installed ($(rustc --version))"
        return 0
    fi
    
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    
    if command_exists cargo; then
        log_success "Rust installed ($(rustc --version))"
    else
        log_error "Rust installation failed"
        return 1
    fi
}

setup_shell_paths() {
    log_info "Setting up shell PATH configuration..."
    
    local shell_config="$HOME/.bashrc"
    
    if [[ "$SHELL" == *"zsh"* ]]; then
        shell_config="$HOME/.zshrc"
    fi
    
    # Backup existing config
    if [ -f "$shell_config" ]; then
        cp "$shell_config" "${shell_config}.backup-$(date +%Y%m%d-%H%M%S)"
    fi
    
    # Add PATH configurations
    cat >> "$shell_config" << 'EOF'

# ============================================
# OpenCode Server Setup Hub - PATH Configuration
# Added by install-base.sh
# ============================================

# Local bin
export PATH="$HOME/.local/bin:$PATH"

# Cargo (Rust)
export PATH="$HOME/.cargo/bin:$PATH"
source "$HOME/.cargo/env" 2>/dev/null || true

# fnm (Node.js)
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd)" 2>/dev/null || true

# mise
eval "$(mise activate bash)" 2>/dev/null || true

EOF
    
    log_success "Shell PATH configured"
}

# ============================================
# Main Installation Flow
# ============================================
main() {
    log "=== Starting Base System Installation ==="
    
    detect_os
    
    install_base_packages
    install_uv
    install_fnm
    install_mise
    install_rustup
    setup_shell_paths
    
    log "=== Base System Installation Complete ==="
    echo ""
    log_success "All base components installed successfully!"
    echo ""
    echo "Next steps:"
    echo "  1. Restart your terminal or run: source ~/.bashrc"
    echo "  2. Verify: uv --version && fnm --version && cargo --version"
    echo ""
}

main "$@"
