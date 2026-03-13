#!/bin/bash
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Installing OpenCode Ecosystem & MCP Servers...${NC}"
echo ""

CONFIG_DIR="$HOME/.config/opencode"
mkdir -p "$CONFIG_DIR"

if ! command -v node &> /dev/null; then
    echo -e "${YELLOW}→ Installing Node.js...${NC}"
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
    echo -e "${GREEN}✓ Node.js installed${NC}"
else
    echo -e "${GREEN}✓ Node.js already installed${NC}"
fi

if ! command -v bun &> /dev/null; then
    echo -e "${YELLOW}→ Installing Bun...${NC}"
    curl -fsSL https://bun.sh/install | bash
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
    echo -e "${GREEN}✓ Bun installed${NC}"
else
    echo -e "${GREEN}✓ Bun already installed${NC}"
fi

echo ""
echo -e "${BLUE}Core OpenCode:${NC}"

if ! command -v opencode &> /dev/null; then
    echo -e "${YELLOW}→ Installing OpenCode CLI...${NC}"
    npm install -g @opencode-ai/cli
    echo -e "${GREEN}✓ OpenCode CLI installed${NC}"
else
    echo -e "${GREEN}✓ OpenCode CLI already installed${NC}"
fi

echo ""
echo -e "${BLUE}OpenCode Plugins & Extensions:${NC}"

echo -e "${YELLOW}→ Installing Oh My OpenCode...${NC}"
npm install -g oh-my-opencode || echo -e "${YELLOW}⚠ Oh My OpenCode installation failed${NC}"
echo -e "${GREEN}✓ Oh My OpenCode installed${NC}"

echo -e "${YELLOW}→ Installing OpenCode Worktree...${NC}"
npm install -g opencode-worktree || echo -e "${YELLOW}⚠ OpenCode Worktree installation failed${NC}"
echo -e "${GREEN}✓ OpenCode Worktree installed${NC}"

echo ""
echo -e "${BLUE}Skills & Superpowers:${NC}"

if [ ! -d "$CONFIG_DIR/superpowers" ]; then
    echo -e "${YELLOW}→ Installing Superpowers skills...${NC}"
    git clone https://github.com/superpowers-ai/superpowers "$CONFIG_DIR/superpowers"
    echo -e "${GREEN}✓ Superpowers skills installed${NC}"
else
    echo -e "${GREEN}✓ Superpowers skills already installed${NC}"
fi

echo ""
echo -e "${BLUE}MCP Servers - Development Tools:${NC}"

echo -e "${YELLOW}→ Installing Filesystem MCP...${NC}"
npm install -g @modelcontextprotocol/server-filesystem
echo -e "${GREEN}✓ Filesystem MCP installed${NC}"

echo -e "${YELLOW}→ Installing Git MCP...${NC}"
uv tool install mcp-server-git
echo -e "${GREEN}✓ Git MCP installed${NC}"

echo -e "${YELLOW}→ Installing GitHub MCP...${NC}"
npm install -g @github/mcp-server
echo -e "${GREEN}✓ GitHub MCP installed${NC}"

echo ""
echo -e "${BLUE}MCP Servers - AI & Memory:${NC}"

echo -e "${YELLOW}→ Installing Memory MCP...${NC}"
npm install -g @modelcontextprotocol/server-memory
echo -e "${GREEN}✓ Memory MCP installed${NC}"

echo -e "${YELLOW}→ Installing Sequential Thinking MCP...${NC}"
npm install -g @modelcontextprotocol/server-sequential-thinking
echo -e "${GREEN}✓ Sequential Thinking MCP installed${NC}"

echo -e "${YELLOW}→ Installing Qdrant MCP...${NC}"
uv tool install mcp-server-qdrant
echo -e "${GREEN}✓ Qdrant MCP installed${NC}"

echo ""
echo -e "${BLUE}MCP Servers - Web & Search:${NC}"

echo -e "${YELLOW}→ Installing Tavily MCP...${NC}"
npm install -g tavily-mcp
echo -e "${GREEN}✓ Tavily MCP installed${NC}"

echo -e "${YELLOW}→ Installing Firecrawl MCP...${NC}"
npm install -g firecrawl-mcp
echo -e "${GREEN}✓ Firecrawl MCP installed${NC}"

echo -e "${YELLOW}→ Installing Brave Search MCP...${NC}"
npm install -g @brave/brave-search-mcp
echo -e "${GREEN}✓ Brave Search MCP installed${NC}"

echo ""
echo -e "${BLUE}MCP Servers - Databases:${NC}"

echo -e "${YELLOW}→ Installing PostgreSQL MCP...${NC}"
npm install -g postgresql-mcp
echo -e "${GREEN}✓ PostgreSQL MCP installed${NC}"

echo -e "${YELLOW}→ Installing SQLite MCP...${NC}"
npm install -g @modelcontextprotocol/server-sqlite
echo -e "${GREEN}✓ SQLite MCP installed${NC}"

echo ""
echo -e "${BLUE}MCP Servers - Browser Automation:${NC}"

echo -e "${YELLOW}→ Installing Playwright MCP...${NC}"
npm install -g @playwright/mcp
npx playwright install chromium
echo -e "${GREEN}✓ Playwright MCP installed${NC}"

echo -e "${YELLOW}→ Installing Puppeteer MCP...${NC}"
npm install -g @modelcontextprotocol/server-puppeteer
echo -e "${GREEN}✓ Puppeteer MCP installed${NC}"

echo ""
echo -e "${BLUE}MCP Servers - Productivity:${NC}"

echo -e "${YELLOW}→ Installing Linear MCP...${NC}"
npm install -g linear-mcp || echo -e "${YELLOW}⚠ Linear MCP installation failed${NC}"

echo -e "${YELLOW}→ Installing Notion MCP...${NC}"
npm install -g notion-mcp || echo -e "${YELLOW}⚠ Notion MCP installation failed${NC}"

echo ""
echo -e "${BLUE}Additional Tools:${NC}"

echo -e "${YELLOW}→ Installing Context7 (documentation search)...${NC}"
npm install -g context7 || echo -e "${YELLOW}⚠ Context7 installation failed${NC}"

echo ""
echo -e "${GREEN}OpenCode ecosystem installation complete!${NC}"
echo ""
echo -e "${YELLOW}Configuration:${NC}"
echo "  • Config directory: $CONFIG_DIR"
echo "  • Edit config: nano $CONFIG_DIR/opencode.json"
echo "  • Edit environment: nano $CONFIG_DIR/.env"
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo "  1. Configure API keys in $CONFIG_DIR/.env"
echo "  2. Test OpenCode: opencode --version"
echo "  3. List models: opencode models"
echo "  4. Start coding: opencode"
