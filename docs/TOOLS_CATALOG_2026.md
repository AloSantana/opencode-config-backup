# 2026 Developer Tools Catalog

**Last Updated:** 2026-03-13

Comprehensive catalog of modern development tools, organized by category with installation instructions and use cases.

---

## Table of Contents

1. [Package Managers](#package-managers)
2. [Modern CLI Tools](#modern-cli-tools)
3. [Git & Version Control](#git--version-control)
4. [Container & Orchestration](#container--orchestration)
5. [Infrastructure as Code](#infrastructure-as-code)
6. [Cloud CLI Tools](#cloud-cli-tools)
7. [AI & LLM Tools](#ai--llm-tools)
8. [Database Tools](#database-tools)
9. [API Development](#api-development)
10. [Monitoring & Observability](#monitoring--observability)

---

## Package Managers

### uv (Python)
**10-100x faster than pip**

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

**Features:**
- Rust-based, extremely fast
- Drop-in pip replacement
- Virtual environment management
- Lock file support

**Usage:**
```bash
uv pip install package
uv venv
uv pip compile requirements.in
```

---

### Bun (JavaScript)
**All-in-one JavaScript runtime & toolkit**

```bash
curl -fsSL https://bun.sh/install | bash
```

**Features:**
- 3x faster than npm
- Built-in bundler, transpiler, test runner
- Drop-in Node.js replacement
- Native TypeScript support

**Usage:**
```bash
bun install
bun run dev
bun test
```

---

### pnpm (JavaScript)
**Fast, disk space efficient package manager**

```bash
npm install -g pnpm
```

**Features:**
- Saves 50%+ disk space
- Faster than npm/yarn
- Strict dependency resolution
- Monorepo support

---

## Modern CLI Tools

### File Navigation

#### eza
**Modern ls replacement**

```bash
cargo install eza
alias ls='eza --icons'
alias ll='eza -l --icons'
alias tree='eza --tree --icons'
```

**Features:**
- Git integration
- Icons support
- Color coding
- Tree view

---

#### fd
**Modern find replacement**

```bash
cargo install fd-find
```

**Usage:**
```bash
fd pattern
fd -e js
fd -H hidden-file
```

**Features:**
- 5x faster than find
- Respects .gitignore
- Regex support
- Parallel execution

---

#### zoxide
**Smarter cd command**

```bash
cargo install zoxide
eval "$(zoxide init bash)"
```

**Usage:**
```bash
z project
zi  # Interactive selection
```

**Features:**
- Learns your habits
- Fuzzy matching
- Cross-platform

---

### File Viewing

#### bat
**Modern cat with syntax highlighting**

```bash
cargo install bat
alias cat='bat'
```

**Features:**
- Syntax highlighting
- Git integration
- Line numbers
- Paging support

---

#### ripgrep (rg)
**Faster grep**

```bash
cargo install ripgrep
```

**Usage:**
```bash
rg pattern
rg -t js pattern
rg -i case-insensitive
```

**Features:**
- 10x faster than grep
- Respects .gitignore
- Unicode support
- Parallel search

---

#### fzf
**Fuzzy finder**

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

**Usage:**
```bash
vim $(fzf)
history | fzf
```

**Features:**
- Interactive filtering
- Vim/Emacs integration
- Preview window
- Multi-select

---

### Process Monitoring

#### btop
**Modern htop**

```bash
sudo apt install btop
```

**Features:**
- Beautiful UI
- Mouse support
- Process tree
- Network monitoring

---

#### procs
**Modern ps**

```bash
cargo install procs
```

**Features:**
- Colored output
- Tree view
- Search/filter
- Docker support

---

### JSON/YAML Tools

#### jq
**JSON processor**

```bash
sudo apt install jq
```

**Usage:**
```bash
cat file.json | jq '.key'
curl api.com | jq '.data[]'
```

---

#### yq
**YAML processor**

```bash
wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq
chmod +x /usr/local/bin/yq
```

**Usage:**
```bash
yq '.key' file.yaml
yq -i '.key = "value"' file.yaml
```

---

#### fx
**Interactive JSON viewer**

```bash
npm install -g fx
```

**Usage:**
```bash
cat file.json | fx
fx file.json
```

---

## Git & Version Control

### lazygit
**Terminal UI for git**

```bash
brew install lazygit
```

**Features:**
- Interactive staging
- Branch management
- Commit history
- Merge conflict resolution

---

### delta
**Better git diff**

```bash
cargo install git-delta
git config --global core.pager delta
```

**Features:**
- Syntax highlighting
- Side-by-side diffs
- Line numbers
- Git blame integration

---

### gh
**GitHub CLI**

```bash
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list
sudo apt update && sudo apt install gh
```

**Usage:**
```bash
gh pr create
gh issue list
gh repo clone
gh workflow run
```

---

## Container & Orchestration

### Docker Tools

#### lazydocker
**Terminal UI for Docker**

```bash
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
```

**Features:**
- Container management
- Log viewing
- Resource monitoring
- Compose support

---

#### dive
**Docker image analyzer**

```bash
wget https://github.com/wagoodman/dive/releases/latest/download/dive_*_linux_amd64.deb
sudo apt install ./dive_*_linux_amd64.deb
```

**Usage:**
```bash
dive image:tag
```

**Features:**
- Layer analysis
- Wasted space detection
- Efficiency score
- CI integration

---

### Kubernetes Tools

#### k9s
**Terminal UI for Kubernetes**

```bash
curl -sS https://webinstall.dev/k9s | bash
```

**Features:**
- Resource management
- Log streaming
- Port forwarding
- Shell access

---

#### kubectl
**Kubernetes CLI**

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/
```

---

#### helm
**Kubernetes package manager**

```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

---

## Infrastructure as Code

### Terraform
**Infrastructure provisioning**

```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

---

### Pulumi
**Infrastructure as code with real programming languages**

```bash
curl -fsSL https://get.pulumi.com | sh
```

**Features:**
- TypeScript/Python/Go support
- State management
- Policy as code
- Secrets management

---

### Ansible
**Configuration management**

```bash
sudo apt install ansible
```

---

## Cloud CLI Tools

### AWS CLI

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

---

### Google Cloud SDK

```bash
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt update && sudo apt install google-cloud-cli
```

---

### Azure CLI

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

---

## AI & LLM Tools

### Ollama
**Local LLM runtime**

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

**Usage:**
```bash
ollama run llama2
ollama pull mistral
ollama list
```

---

### LiteLLM
**Unified LLM API**

```bash
pip install litellm
```

**Features:**
- 100+ LLM support
- Unified API format
- Load balancing
- Cost tracking

---

### LangChain
**LLM application framework**

```bash
pip install langchain langchain-openai langchain-anthropic
```

---

### CrewAI
**Multi-agent orchestration**

```bash
pip install crewai crewai-tools
```

---

## Database Tools

### PostgreSQL Tools

#### pgcli
**PostgreSQL CLI with autocomplete**

```bash
pip install pgcli
```

---

#### DBeaver
**Universal database tool**

```bash
sudo snap install dbeaver-ce
```

---

### Redis Tools

#### redis-cli
**Redis command-line interface**

```bash
sudo apt install redis-tools
```

---

## API Development

### httpie
**User-friendly HTTP client**

```bash
sudo apt install httpie
```

**Usage:**
```bash
http GET api.com/users
http POST api.com/users name=John
```

---

### xh
**Faster httpie (Rust)**

```bash
cargo install xh
```

---

### Postman CLI

```bash
curl -o- "https://dl-cli.pstmn.io/install/linux64.sh" | sh
```

---

## Monitoring & Observability

### Prometheus
**Metrics collection**

```bash
docker run -p 9090:9090 prom/prometheus
```

---

### Grafana
**Metrics visualization**

```bash
docker run -p 3000:3000 grafana/grafana
```

---

### Jaeger
**Distributed tracing**

```bash
docker run -p 16686:16686 jaegertracing/all-in-one
```

---

## Terminal Enhancements

### tmux
**Terminal multiplexer**

```bash
sudo apt install tmux
```

---

### zellij
**Modern tmux alternative**

```bash
cargo install zellij
```

---

### starship
**Cross-shell prompt**

```bash
cargo install starship
eval "$(starship init bash)"
```

---

## Shell Enhancements

### fish
**Friendly interactive shell**

```bash
sudo apt install fish
chsh -s $(which fish)
```

---

### zsh + oh-my-zsh

```bash
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

---

**Generated:** 2026-03-13  
**Maintained by:** OpenCode Community
