#!/bin/bash
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}Installing DevOps Tools...${NC}"
echo ""

echo -e "${BLUE}Docker & Container Tools:${NC}"

if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}→ Installing Docker...${NC}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
    echo -e "${GREEN}✓ Docker installed${NC}"
    echo -e "${YELLOW}⚠ Please log out and back in for Docker group changes to take effect${NC}"
else
    echo -e "${GREEN}✓ Docker already installed${NC}"
fi

if ! command -v docker-compose &> /dev/null; then
    echo -e "${YELLOW}→ Installing Docker Compose...${NC}"
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo -e "${GREEN}✓ Docker Compose installed${NC}"
else
    echo -e "${GREEN}✓ Docker Compose already installed${NC}"
fi

if ! command -v lazydocker &> /dev/null; then
    echo -e "${YELLOW}→ Installing lazydocker...${NC}"
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    echo -e "${GREEN}✓ lazydocker installed${NC}"
else
    echo -e "${GREEN}✓ lazydocker already installed${NC}"
fi

if ! command -v dive &> /dev/null; then
    echo -e "${YELLOW}→ Installing dive...${NC}"
    DIVE_VERSION=$(curl -s "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    wget "https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.deb"
    sudo apt install -y "./dive_${DIVE_VERSION}_linux_amd64.deb"
    rm "dive_${DIVE_VERSION}_linux_amd64.deb"
    echo -e "${GREEN}✓ dive installed${NC}"
else
    echo -e "${GREEN}✓ dive already installed${NC}"
fi

echo ""
echo -e "${BLUE}Kubernetes Tools:${NC}"

if ! command -v kubectl &> /dev/null; then
    echo -e "${YELLOW}→ Installing kubectl...${NC}"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm kubectl
    echo -e "${GREEN}✓ kubectl installed${NC}"
else
    echo -e "${GREEN}✓ kubectl already installed${NC}"
fi

if ! command -v k9s &> /dev/null; then
    echo -e "${YELLOW}→ Installing k9s...${NC}"
    curl -sS https://webinstall.dev/k9s | bash
    echo -e "${GREEN}✓ k9s installed${NC}"
else
    echo -e "${GREEN}✓ k9s already installed${NC}"
fi

if ! command -v helm &> /dev/null; then
    echo -e "${YELLOW}→ Installing Helm...${NC}"
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    echo -e "${GREEN}✓ Helm installed${NC}"
else
    echo -e "${GREEN}✓ Helm already installed${NC}"
fi

echo ""
echo -e "${BLUE}Infrastructure as Code:${NC}"

if ! command -v terraform &> /dev/null; then
    echo -e "${YELLOW}→ Installing Terraform...${NC}"
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install -y terraform
    echo -e "${GREEN}✓ Terraform installed${NC}"
else
    echo -e "${GREEN}✓ Terraform already installed${NC}"
fi

if ! command -v ansible &> /dev/null; then
    echo -e "${YELLOW}→ Installing Ansible...${NC}"
    sudo apt update
    sudo apt install -y software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install -y ansible
    echo -e "${GREEN}✓ Ansible installed${NC}"
else
    echo -e "${GREEN}✓ Ansible already installed${NC}"
fi

if ! command -v pulumi &> /dev/null; then
    echo -e "${YELLOW}→ Installing Pulumi...${NC}"
    curl -fsSL https://get.pulumi.com | sh
    echo -e "${GREEN}✓ Pulumi installed${NC}"
else
    echo -e "${GREEN}✓ Pulumi already installed${NC}"
fi

echo ""
echo -e "${BLUE}CI/CD Tools:${NC}"

if ! command -v act &> /dev/null; then
    echo -e "${YELLOW}→ Installing act (GitHub Actions locally)...${NC}"
    curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
    echo -e "${GREEN}✓ act installed${NC}"
else
    echo -e "${GREEN}✓ act already installed${NC}"
fi

echo ""
echo -e "${BLUE}Cloud CLI Tools:${NC}"

if ! command -v aws &> /dev/null; then
    echo -e "${YELLOW}→ Installing AWS CLI...${NC}"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -q awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip
    echo -e "${GREEN}✓ AWS CLI installed${NC}"
else
    echo -e "${GREEN}✓ AWS CLI already installed${NC}"
fi

if ! command -v gcloud &> /dev/null; then
    echo -e "${YELLOW}→ Installing Google Cloud SDK...${NC}"
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    sudo apt-get update && sudo apt-get install -y google-cloud-cli
    echo -e "${GREEN}✓ Google Cloud SDK installed${NC}"
else
    echo -e "${GREEN}✓ Google Cloud SDK already installed${NC}"
fi

if ! command -v az &> /dev/null; then
    echo -e "${YELLOW}→ Installing Azure CLI...${NC}"
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    echo -e "${GREEN}✓ Azure CLI installed${NC}"
else
    echo -e "${GREEN}✓ Azure CLI already installed${NC}"
fi

echo ""
echo -e "${BLUE}Setting up DevOps aliases...${NC}"

SHELL_RC="$HOME/.bashrc"
if [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="$HOME/.zshrc"
fi

if ! grep -q "DevOps aliases" "$SHELL_RC"; then
    cat >> "$SHELL_RC" << 'EOF'

# DevOps aliases
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'
alias ld='lazydocker'
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
EOF
    echo -e "${GREEN}✓ DevOps aliases configured${NC}"
else
    echo -e "${GREEN}✓ DevOps aliases already configured${NC}"
fi

echo ""
echo -e "${GREEN}DevOps tools installation complete!${NC}"
