# MCP Servers Configuration Reference

**Last Updated:** 2026-03-13

Complete reference of all configured MCP (Model Context Protocol) servers with installation details and repository links.

---

## Table of Contents

1. [Development Tools](#development-tools)
2. [AI & Memory](#ai--memory)
3. [Web & Search](#web--search)
4. [Databases](#databases)
5. [Browser Automation](#browser-automation)
6. [Cloud Services](#cloud-services)
7. [Productivity](#productivity)
8. [Monitoring](#monitoring)

---

## Development Tools

### Filesystem
**Package:** `@modelcontextprotocol/server-filesystem`  
**Repository:** https://github.com/modelcontextprotocol/servers  
**Installation:** `npx -y @modelcontextprotocol/server-filesystem`

**Description:** File system operations - read, write, search files and directories.

**Configuration:**
```json
{
  "filesystem": {
    "type": "local",
    "command": ["npx", "-y", "@modelcontextprotocol/server-filesystem", "."],
    "enabled": true
  }
}
```

---

### Git
**Package:** `mcp-server-git`  
**Repository:** https://github.com/modelcontextprotocol/servers  
**Installation:** `uvx mcp-server-git`

**Description:** Git operations - status, diff, log, commit, branch management.

**Configuration:**
```json
{
  "git": {
    "type": "local",
    "command": ["uvx", "mcp-server-git", "--repository", "."],
    "enabled": true
  }
}
```

---

### GitHub
**Package:** `@github/mcp-server`  
**Repository:** https://github.com/github/mcp-server  
**Installation:** `npx -y @github/mcp-server`

**Description:** GitHub API integration - issues, PRs, repos, workflows.

**Configuration:**
```json
{
  "github": {
    "type": "local",
    "command": ["npx", "-y", "@github/mcp-server"],
    "enabled": true,
    "environment": {
      "GITHUB_TOKEN": "${GITHUB_TOKEN}"
    }
  }
}
```

**Required Environment Variables:**
- `GITHUB_TOKEN` - GitHub Personal Access Token

---

### Docker
**Package:** `mcp-server-docker`  
**Repository:** https://github.com/modelcontextprotocol/servers  
**Installation:** `npx -y mcp-server-docker`

**Description:** Docker container management - list, start, stop, logs.

**Configuration:**
```json
{
  "docker": {
    "type": "local",
    "command": ["npx", "-y", "mcp-server-docker"],
    "enabled": true
  }
}
```

---

### Python Analysis
**Package:** `python-lsp-mcp`  
**Repository:** https://github.com/modelcontextprotocol/servers  
**Installation:** `uvx python-lsp-mcp`

**Description:** Python LSP integration - code analysis, refactoring, type checking.

**Configuration:**
```json
{
  "python-analysis": {
    "type": "local",
    "command": ["uvx", "python-lsp-mcp"],
    "enabled": true,
    "environment": {
      "PROJECT_PATH": "."
    }
  }
}
```

---

## AI & Memory

### Memory
**Package:** `@modelcontextprotocol/server-memory`  
**Repository:** https://github.com/modelcontextprotocol/servers  
**Installation:** `npx -y @modelcontextprotocol/server-memory`

**Description:** Knowledge graph memory - store and retrieve contextual information.

**Configuration:**
```json
{
  "memory": {
    "type": "local",
    "command": ["npx", "-y", "@modelcontextprotocol/server-memory"],
    "enabled": true
  }
}
```

---

### Sequential Thinking
**Package:** `@modelcontextprotocol/server-sequential-thinking`  
**Repository:** https://github.com/modelcontextprotocol/servers  
**Installation:** `npx -y @modelcontextprotocol/server-sequential-thinking`

**Description:** Chain-of-thought reasoning for complex problem solving.

**Configuration:**
```json
{
  "sequential-thinking": {
    "type": "local",
    "command": ["npx", "-y", "@modelcontextprotocol/server-sequential-thinking"],
    "enabled": true
  }
}
```

---

### Qdrant
**Package:** `mcp-server-qdrant`  
**Repository:** https://github.com/qdrant/mcp-server-qdrant  
**Installation:** `uvx mcp-server-qdrant`

**Description:** Vector database for semantic search and embeddings.

**Configuration:**
```json
{
  "qdrant": {
    "type": "local",
    "command": ["uvx", "mcp-server-qdrant"],
    "enabled": true,
    "environment": {
      "QDRANT_URL": "${QDRANT_URL}",
      "QDRANT_API_KEY": "${QDRANT_API_KEY}",
      "COLLECTION_NAME": "opencode-agent-memory",
      "EMBEDDING_PROVIDER": "fastembed"
    }
  }
}
```

**Required Environment Variables:**
- `QDRANT_URL` - Qdrant instance URL
- `QDRANT_API_KEY` - Qdrant API key

---

### ChromaDB
**Package:** `chroma-mcp`  
**Repository:** https://github.com/chroma-core/chroma-mcp  
**Installation:** `uvx chroma-mcp`

**Description:** Embedded vector database for AI applications.

**Configuration:**
```json
{
  "chroma": {
    "type": "local",
    "command": ["uvx", "chroma-mcp", "--mode", "embedded", "--data-dir", "./.chroma"],
    "enabled": true
  }
}
```

---

## Web & Search

### Tavily
**Package:** `tavily-mcp`  
**Repository:** https://github.com/tavily-ai/tavily-mcp  
**Installation:** `npx -y tavily-mcp`

**Description:** AI-powered web search optimized for LLMs.

**Configuration:**
```json
{
  "tavily": {
    "type": "local",
    "command": ["npx", "-y", "tavily-mcp"],
    "enabled": true,
    "environment": {
      "TAVILY_API_KEY": "${TAVILY_API_KEY}"
    }
  }
}
```

**Required Environment Variables:**
- `TAVILY_API_KEY` - Tavily API key

---

### Exa
**Package:** `exa-mcp-server`  
**Repository:** https://github.com/exa-labs/exa-mcp  
**Installation:** `npx -y exa-mcp-server`

**Description:** Neural search engine for finding relevant content.

**Configuration:**
```json
{
  "exa": {
    "type": "local",
    "command": ["npx", "-y", "exa-mcp-server"],
    "enabled": true,
    "environment": {
      "EXA_API_KEY": "${EXA_API_KEY}"
    }
  }
}
```

**Required Environment Variables:**
- `EXA_API_KEY` - Exa API key

---

### Brave Search
**Package:** `@brave/brave-search-mcp`  
**Repository:** https://github.com/brave/brave-search-mcp  
**Installation:** `npx -y @brave/brave-search-mcp`

**Description:** Privacy-focused web search.

**Configuration:**
```json
{
  "brave-search": {
    "type": "local",
    "command": ["npx", "-y", "@brave/brave-search-mcp"],
    "enabled": true,
    "environment": {
      "BRAVE_API_KEY": "${BRAVE_API_KEY}"
    }
  }
}
```

**Required Environment Variables:**
- `BRAVE_API_KEY` - Brave Search API key

---

### Firecrawl
**Package:** `firecrawl-mcp`  
**Repository:** https://github.com/mendableai/firecrawl-mcp  
**Installation:** `npx -y firecrawl-mcp`

**Description:** Web scraping and crawling with AI-powered extraction.

**Configuration:**
```json
{
  "firecrawl": {
    "type": "local",
    "command": ["npx", "-y", "firecrawl-mcp"],
    "enabled": true,
    "environment": {
      "FIRECRAWL_API_KEY": "${FIRECRAWL_API_KEY}"
    }
  }
}
```

**Required Environment Variables:**
- `FIRECRAWL_API_KEY` - Firecrawl API key

---

### Fetch
**Package:** `mcp-server-fetch`  
**Repository:** https://github.com/modelcontextprotocol/servers  
**Installation:** `uvx mcp-server-fetch`

**Description:** HTTP client for fetching web content.

**Configuration:**
```json
{
  "fetch": {
    "type": "local",
    "command": ["uvx", "mcp-server-fetch"],
    "enabled": true
  }
}
```

---

### Context7
**Package:** `@upstash/context7-mcp`  
**Repository:** https://github.com/upstash/context7-mcp  
**Installation:** `npx -y @upstash/context7-mcp`

**Description:** Documentation search for programming libraries and frameworks.

**Configuration:**
```json
{
  "context7": {
    "type": "local",
    "command": ["npx", "-y", "@upstash/context7-mcp"],
    "enabled": true,
    "environment": {
      "CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}"
    }
  }
}
```

**Required Environment Variables:**
- `CONTEXT7_API_KEY` - Context7 API key

---

## Databases

### PostgreSQL
**Package:** `postgresql-mcp`  
**Repository:** https://github.com/modelcontextprotocol/servers  
**Installation:** `npx -y postgresql-mcp`

**Description:** PostgreSQL database operations.

**Configuration:**
```json
{
  "postgres": {
    "type": "local",
    "command": ["npx", "-y", "postgresql-mcp"],
    "enabled": true,
    "environment": {
      "POSTGRES_CONNECTION_STRING": "${POSTGRES_CONNECTION_STRING}"
    }
  }
}
```

**Required Environment Variables:**
- `POSTGRES_CONNECTION_STRING` - PostgreSQL connection string

---

### SQLite
**Package:** `@modelcontextprotocol/server-sqlite`  
**Repository:** https://github.com/modelcontextprotocol/servers  
**Installation:** `npx -y @modelcontextprotocol/server-sqlite`

**Description:** SQLite database operations.

**Configuration:**
```json
{
  "sqlite": {
    "type": "local",
    "command": ["npx", "-y", "@modelcontextprotocol/server-sqlite", "--db-path", "./data.db"],
    "enabled": true
  }
}
```

---

### Neon
**Package:** `@neondatabase/mcp-server-neon`  
**Repository:** https://github.com/neondatabase/mcp-server-neon  
**Installation:** `npx -y @neondatabase/mcp-server-neon`

**Description:** Neon serverless PostgreSQL integration.

**Configuration:**
```json
{
  "neon": {
    "type": "local",
    "command": ["npx", "-y", "@neondatabase/mcp-server-neon"],
    "enabled": true,
    "environment": {
      "NEON_API_KEY": "${NEON_API_KEY}"
    }
  }
}
```

**Required Environment Variables:**
- `NEON_API_KEY` - Neon API key

---

### Upstash Redis
**Package:** `@upstash/mcp-server`  
**Repository:** https://github.com/upstash/mcp-server  
**Installation:** `npx -y @upstash/mcp-server`

**Description:** Serverless Redis operations.

**Configuration:**
```json
{
  "upstash": {
    "type": "local",
    "command": ["npx", "-y", "@upstash/mcp-server"],
    "enabled": true,
    "environment": {
      "UPSTASH_REDIS_REST_URL": "${UPSTASH_REDIS_REST_URL}",
      "UPSTASH_REDIS_REST_TOKEN": "${UPSTASH_REDIS_REST_TOKEN}"
    }
  }
}
```

**Required Environment Variables:**
- `UPSTASH_REDIS_REST_URL` - Upstash Redis REST URL
- `UPSTASH_REDIS_REST_TOKEN` - Upstash Redis REST token

---

## Browser Automation

### Playwright
**Package:** `@playwright/mcp`  
**Repository:** https://github.com/playwright/mcp  
**Installation:** `npx -y @playwright/mcp`

**Description:** Browser automation with Playwright.

**Configuration:**
```json
{
  "playwright": {
    "type": "local",
    "command": ["npx", "-y", "@playwright/mcp", "--headless"],
    "enabled": true
  }
}
```

---

### Puppeteer
**Package:** `@modelcontextprotocol/server-puppeteer`  
**Repository:** https://github.com/modelcontextprotocol/servers  
**Installation:** `npx -y @modelcontextprotocol/server-puppeteer`

**Description:** Browser automation with Puppeteer.

**Configuration:**
```json
{
  "puppeteer": {
    "type": "local",
    "command": ["npx", "-y", "@modelcontextprotocol/server-puppeteer"],
    "enabled": true
  }
}
```

---

## Cloud Services

### Daytona
**Package:** `daytona`  
**Repository:** https://github.com/daytonaio/daytona  
**Installation:** Via Daytona CLI

**Description:** Development environment management.

**Configuration:**
```json
{
  "daytona": {
    "type": "local",
    "command": ["daytona", "mcp", "start"],
    "enabled": true,
    "environment": {
      "DAYTONA_API_KEY": "${DAYTONA_API_KEY}",
      "DAYTONA_SERVER_URL": "${DAYTONA_SERVER_URL}"
    }
  }
}
```

**Required Environment Variables:**
- `DAYTONA_API_KEY` - Daytona API key
- `DAYTONA_SERVER_URL` - Daytona server URL

---

### OpenRouter
**Package:** `openrouter-mcp`  
**Repository:** https://github.com/openrouter/mcp-server  
**Installation:** `npx -y openrouter-mcp`

**Description:** Multi-provider LLM routing.

**Configuration:**
```json
{
  "openrouter": {
    "type": "local",
    "command": ["npx", "-y", "openrouter-mcp"],
    "enabled": true,
    "environment": {
      "OPENROUTER_API_KEY": "${OPENROUTER_API_KEY}"
    }
  }
}
```

**Required Environment Variables:**
- `OPENROUTER_API_KEY` - OpenRouter API key

---

## Productivity

### Linear
**Package:** `linear-mcp-server`  
**Repository:** https://github.com/linear/mcp-server  
**Installation:** `npx -y linear-mcp-server`

**Description:** Linear issue tracking integration.

**Configuration:**
```json
{
  "linear": {
    "type": "local",
    "command": ["npx", "-y", "linear-mcp-server"],
    "enabled": true,
    "environment": {
      "LINEAR_API_KEY": "${LINEAR_API_KEY}"
    }
  }
}
```

**Required Environment Variables:**
- `LINEAR_API_KEY` - Linear API key

---

### Notion
**Package:** `@notionhq/notion-mcp-server`  
**Repository:** https://github.com/notionhq/notion-mcp-server  
**Installation:** `npx -y @notionhq/notion-mcp-server`

**Description:** Notion workspace integration.

**Configuration:**
```json
{
  "notion": {
    "type": "local",
    "command": ["npx", "-y", "@notionhq/notion-mcp-server"],
    "enabled": true,
    "environment": {
      "NOTION_API_KEY": "${NOTION_API_KEY}"
    }
  }
}
```

**Required Environment Variables:**
- `NOTION_API_KEY` - Notion integration token

---

### n8n
**Package:** `n8n-mcp`  
**Repository:** https://github.com/n8n-io/mcp-server  
**Installation:** `npx -y n8n-mcp`

**Description:** n8n workflow automation integration.

**Configuration:**
```json
{
  "n8n": {
    "type": "local",
    "command": ["npx", "-y", "n8n-mcp"],
    "enabled": true,
    "environment": {
      "N8N_API_KEY": "${N8N_API_KEY}",
      "N8N_BASE_URL": "${N8N_BASE_URL}"
    }
  }
}
```

**Required Environment Variables:**
- `N8N_API_KEY` - n8n API key
- `N8N_BASE_URL` - n8n instance URL

---

### TaskMaster AI
**Package:** `task-master-ai`  
**Repository:** https://github.com/taskmaster-ai/mcp-server  
**Installation:** `npx -y --package=task-master-ai task-master-ai`

**Description:** AI-powered task management.

**Configuration:**
```json
{
  "taskmaster-ai": {
    "type": "local",
    "command": ["npx", "-y", "--package=task-master-ai", "task-master-ai"],
    "enabled": true,
    "environment": {
      "GEMINI_API_KEY": "${GEMINI_API_KEY}"
    }
  }
}
```

**Required Environment Variables:**
- `GEMINI_API_KEY` - Google Gemini API key

---

## Monitoring

### AgentOps
**Package:** `agentops-mcp`  
**Repository:** https://github.com/agentops-ai/mcp-server  
**Installation:** `npx -y agentops-mcp`

**Description:** Agent observability and monitoring.

**Configuration:**
```json
{
  "agentops": {
    "type": "local",
    "command": ["npx", "-y", "agentops-mcp"],
    "enabled": true,
    "environment": {
      "AGENTOPS_API_KEY": "${AGENTOPS_API_KEY}"
    }
  }
}
```

**Required Environment Variables:**
- `AGENTOPS_API_KEY` - AgentOps API key

---

## Utilities

### Time
**Package:** `mcp-server-time`  
**Repository:** https://github.com/modelcontextprotocol/servers  
**Installation:** `uvx mcp-server-time`

**Description:** Time and timezone operations.

**Configuration:**
```json
{
  "time": {
    "type": "local",
    "command": ["uvx", "mcp-server-time"],
    "enabled": true
  }
}
```

---

### YouTube Downloader
**Package:** `@kevinwatt/yt-dlp-mcp`  
**Repository:** https://github.com/kevinwatt/yt-dlp-mcp  
**Installation:** `npx -y @kevinwatt/yt-dlp-mcp`

**Description:** YouTube video download and metadata extraction.

**Configuration:**
```json
{
  "yt-dlp": {
    "type": "local",
    "command": ["npx", "-y", "@kevinwatt/yt-dlp-mcp"],
    "enabled": true
  }
}
```

---

### Mermaid (Disabled)
**Package:** `@narasimhaponnada/mermaid-mcp-server`  
**Repository:** https://github.com/narasimhaponnada/mermaid-mcp-server  
**Installation:** `npx -y @narasimhaponnada/mermaid-mcp-server`

**Description:** Mermaid diagram generation.

**Configuration:**
```json
{
  "mermaid": {
    "type": "local",
    "command": ["npx", "-y", "@narasimhaponnada/mermaid-mcp-server"],
    "enabled": false
  }
}
```

---

## Summary

**Total MCP Servers:** 31  
**Enabled:** 30  
**Disabled:** 1 (mermaid)

**Categories:**
- Development Tools: 5
- AI & Memory: 3
- Web & Search: 6
- Databases: 4
- Browser Automation: 2
- Cloud Services: 2
- Productivity: 4
- Monitoring: 1
- Utilities: 3

---

## Installation

All MCP servers are automatically installed when running:

```bash
./install/install-opencode.sh
```

Or install individually:

```bash
# npm packages
npx -y <package-name>

# Python packages
uvx <package-name>
```

---

## Configuration

MCP servers are configured in `~/.config/opencode/opencode.json` under the `mcp` section.

Environment variables should be set in `~/.config/opencode/.env`.

---

**Generated:** 2026-03-13  
**Maintained by:** OpenCode Community
