#!/bin/bash
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/opencode"
MANIFEST_FILE="$CONFIG_DIR/manifest.json"
LOG_FILE="$HOME/opencode-install-$(date +%Y%m%d-%H%M%S).log"

log() {
    echo -e "$1" | tee -a "$LOG_FILE"
}

error() {
    log "${RED}ERROR: $1${NC}"
    exit 1
}

success() {
    log "${GREEN}✓ $1${NC}"
}

info() {
    log "${BLUE}→ $1${NC}"
}

warn() {
    log "${YELLOW}⚠ $1${NC}"
}

check_command() {
    if command -v "$1" &> /dev/null; then
        return 0
    else
        return 1
    fi
}

log "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
log "${BLUE}║  OpenCode & AI Development Environment Installer          ║${NC}"
log "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
log ""
log "Installation log: $LOG_FILE"
log ""

if [ ! -f "$MANIFEST_FILE" ]; then
    warn "No manifest.json found. Running setup wizard first..."
    if [ -f "$SCRIPT_DIR/setup-wizard.sh" ]; then
        bash "$SCRIPT_DIR/setup-wizard.sh"
    else
        error "setup-wizard.sh not found. Please run it manually first."
    fi
fi

if [ -f "$MANIFEST_FILE" ]; then
    info "Loading configuration from $MANIFEST_FILE"
    
    INSTALL_BASE=$(jq -r '.components.base' "$MANIFEST_FILE")
    INSTALL_CLI=$(jq -r '.components.cli' "$MANIFEST_FILE")
    INSTALL_DEVOPS=$(jq -r '.components.devops' "$MANIFEST_FILE")
    INSTALL_AI=$(jq -r '.components.ai' "$MANIFEST_FILE")
    INSTALL_OPENCODE=$(jq -r '.components.opencode' "$MANIFEST_FILE")
    INSTALL_ANDROID=$(jq -r '.components.android' "$MANIFEST_FILE")
fi

INSTALL_BASE=${INSTALL_BASE:-true}
INSTALL_CLI=${INSTALL_CLI:-true}
INSTALL_DEVOPS=${INSTALL_DEVOPS:-false}
INSTALL_AI=${INSTALL_AI:-true}
INSTALL_OPENCODE=${INSTALL_OPENCODE:-true}
INSTALL_ANDROID=${INSTALL_ANDROID:-false}

log "${YELLOW}Installation Plan:${NC}"
log "  Base System: $INSTALL_BASE"
log "  CLI Tools: $INSTALL_CLI"
log "  DevOps: $INSTALL_DEVOPS"
log "  AI Frameworks: $INSTALL_AI"
log "  OpenCode: $INSTALL_OPENCODE"
log "  Android Tools: $INSTALL_ANDROID"
log ""

if [ "$INSTALL_BASE" = "true" ]; then
    info "Installing base system packages..."
    if [ -f "$SCRIPT_DIR/install/install-base.sh" ]; then
        bash "$SCRIPT_DIR/install/install-base.sh" 2>&1 | tee -a "$LOG_FILE"
        success "Base system installation complete"
    else
        warn "install-base.sh not found, skipping"
    fi
fi

if [ "$INSTALL_CLI" = "true" ]; then
    info "Installing modern CLI tools..."
    if [ -f "$SCRIPT_DIR/install/install-cli.sh" ]; then
        bash "$SCRIPT_DIR/install/install-cli.sh" 2>&1 | tee -a "$LOG_FILE"
        success "CLI tools installation complete"
    else
        warn "install-cli.sh not found, skipping"
    fi
fi

if [ "$INSTALL_DEVOPS" = "true" ]; then
    info "Installing DevOps tools..."
    if [ -f "$SCRIPT_DIR/install/install-devops.sh" ]; then
        bash "$SCRIPT_DIR/install/install-devops.sh" 2>&1 | tee -a "$LOG_FILE"
        success "DevOps tools installation complete"
    else
        warn "install-devops.sh not found, skipping"
    fi
fi

if [ "$INSTALL_AI" = "true" ]; then
    info "Installing AI frameworks..."
    if [ -f "$SCRIPT_DIR/install/install-ai.sh" ]; then
        bash "$SCRIPT_DIR/install/install-ai.sh" 2>&1 | tee -a "$LOG_FILE"
        success "AI frameworks installation complete"
    else
        warn "install-ai.sh not found, skipping"
    fi
fi

if [ "$INSTALL_OPENCODE" = "true" ]; then
    info "Installing OpenCode ecosystem..."
    if [ -f "$SCRIPT_DIR/install/install-opencode.sh" ]; then
        bash "$SCRIPT_DIR/install/install-opencode.sh" 2>&1 | tee -a "$LOG_FILE"
        success "OpenCode installation complete"
    else
        warn "install-opencode.sh not found, skipping"
    fi
fi

if [ "$INSTALL_ANDROID" = "true" ]; then
    info "Installing Android remote access tools..."
    if [ -f "$SCRIPT_DIR/install/install-android.sh" ]; then
        bash "$SCRIPT_DIR/install/install-android.sh" 2>&1 | tee -a "$LOG_FILE"
        success "Android tools installation complete"
    else
        warn "install-android.sh not found, skipping"
    fi
fi

info "Running post-installation verification..."
if [ -f "$SCRIPT_DIR/scripts/verify-install.sh" ]; then
    bash "$SCRIPT_DIR/scripts/verify-install.sh" 2>&1 | tee -a "$LOG_FILE"
else
    warn "verify-install.sh not found, skipping verification"
fi

log ""
log "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
log "${GREEN}║  Installation Complete!                                    ║${NC}"
log "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
log ""
log "${YELLOW}Next Steps:${NC}"
log "  1. Restart your terminal or run: source ~/.bashrc"
log "  2. Verify installation: opencode --version"
log "  3. Configure API keys: nano $CONFIG_DIR/.env"
log "  4. Review installation log: cat $LOG_FILE"
log ""
log "${BLUE}Documentation:${NC}"
log "  • Installation Hub: $SCRIPT_DIR/INSTALLATION_HUB.md"
log "  • Tools Catalog: $SCRIPT_DIR/docs/TOOLS_CATALOG_2026.md"
log "  • LLM Guide: $SCRIPT_DIR/docs/LLM_INSTALL_GUIDE.md"
log ""
