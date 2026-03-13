#!/bin/bash
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Installing AI Frameworks & Agent Tools...${NC}"
echo ""

if ! command -v uv &> /dev/null; then
    echo -e "${YELLOW}→ Installing uv (fast Python package manager)...${NC}"
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
    echo -e "${GREEN}✓ uv installed${NC}"
else
    echo -e "${GREEN}✓ uv already installed${NC}"
fi

if ! command -v python3 &> /dev/null; then
    echo -e "${YELLOW}→ Installing Python 3...${NC}"
    sudo apt update
    sudo apt install -y python3 python3-pip python3-venv
    echo -e "${GREEN}✓ Python 3 installed${NC}"
else
    echo -e "${GREEN}✓ Python 3 already installed${NC}"
fi

echo ""
echo -e "${BLUE}AI Agent Frameworks:${NC}"

echo -e "${YELLOW}→ Installing LangChain...${NC}"
uv pip install --system langchain langchain-openai langchain-anthropic langchain-google-genai langchain-community
echo -e "${GREEN}✓ LangChain installed${NC}"

echo -e "${YELLOW}→ Installing CrewAI...${NC}"
uv pip install --system crewai crewai-tools
echo -e "${GREEN}✓ CrewAI installed${NC}"

echo -e "${YELLOW}→ Installing LiteLLM...${NC}"
uv pip install --system litellm
echo -e "${GREEN}✓ LiteLLM installed${NC}"

echo -e "${YELLOW}→ Installing AutoGen...${NC}"
uv pip install --system pyautogen
echo -e "${GREEN}✓ AutoGen installed${NC}"

echo ""
echo -e "${BLUE}AI Observability & Monitoring:${NC}"

echo -e "${YELLOW}→ Installing AgentOps...${NC}"
uv pip install --system agentops
echo -e "${GREEN}✓ AgentOps installed${NC}"

echo -e "${YELLOW}→ Installing LangSmith...${NC}"
uv pip install --system langsmith
echo -e "${GREEN}✓ LangSmith installed${NC}"

echo -e "${YELLOW}→ Installing OpenTelemetry...${NC}"
uv pip install --system opentelemetry-api opentelemetry-sdk
echo -e "${GREEN}✓ OpenTelemetry installed${NC}"

echo ""
echo -e "${BLUE}Vector Databases & Embeddings:${NC}"

echo -e "${YELLOW}→ Installing Qdrant client...${NC}"
uv pip install --system qdrant-client
echo -e "${GREEN}✓ Qdrant client installed${NC}"

echo -e "${YELLOW}→ Installing ChromaDB...${NC}"
uv pip install --system chromadb
echo -e "${GREEN}✓ ChromaDB installed${NC}"

echo -e "${YELLOW}→ Installing FAISS...${NC}"
uv pip install --system faiss-cpu
echo -e "${GREEN}✓ FAISS installed${NC}"

echo -e "${YELLOW}→ Installing sentence-transformers...${NC}"
uv pip install --system sentence-transformers
echo -e "${GREEN}✓ sentence-transformers installed${NC}"

echo ""
echo -e "${BLUE}LLM Utilities:${NC}"

echo -e "${YELLOW}→ Installing tiktoken (token counting)...${NC}"
uv pip install --system tiktoken
echo -e "${GREEN}✓ tiktoken installed${NC}"

echo -e "${YELLOW}→ Installing guidance (structured generation)...${NC}"
uv pip install --system guidance
echo -e "${GREEN}✓ guidance installed${NC}"

echo -e "${YELLOW}→ Installing instructor (structured outputs)...${NC}"
uv pip install --system instructor
echo -e "${GREEN}✓ instructor installed${NC}"

echo ""
echo -e "${BLUE}AI Development Tools:${NC}"

echo -e "${YELLOW}→ Installing Jupyter...${NC}"
uv pip install --system jupyter jupyterlab ipykernel
echo -e "${GREEN}✓ Jupyter installed${NC}"

echo -e "${YELLOW}→ Installing Streamlit...${NC}"
uv pip install --system streamlit
echo -e "${GREEN}✓ Streamlit installed${NC}"

echo -e "${YELLOW}→ Installing Gradio...${NC}"
uv pip install --system gradio
echo -e "${GREEN}✓ Gradio installed${NC}"

echo ""
echo -e "${BLUE}Model Serving & Inference:${NC}"

if ! command -v ollama &> /dev/null; then
    echo -e "${YELLOW}→ Installing Ollama (local LLM runtime)...${NC}"
    curl -fsSL https://ollama.com/install.sh | sh
    echo -e "${GREEN}✓ Ollama installed${NC}"
else
    echo -e "${GREEN}✓ Ollama already installed${NC}"
fi

echo -e "${YELLOW}→ Installing vLLM...${NC}"
uv pip install --system vllm || echo -e "${YELLOW}⚠ vLLM installation skipped (requires CUDA)${NC}"

echo ""
echo -e "${BLUE}JavaScript AI Libraries:${NC}"

if command -v npm &> /dev/null; then
    echo -e "${YELLOW}→ Installing LangChain.js...${NC}"
    npm install -g langchain @langchain/openai @langchain/anthropic
    echo -e "${GREEN}✓ LangChain.js installed${NC}"
    
    echo -e "${YELLOW}→ Installing Vercel AI SDK...${NC}"
    npm install -g ai
    echo -e "${GREEN}✓ Vercel AI SDK installed${NC}"
else
    echo -e "${YELLOW}⚠ npm not found, skipping JavaScript AI libraries${NC}"
fi

echo ""
echo -e "${GREEN}AI frameworks installation complete!${NC}"
echo ""
echo -e "${YELLOW}Quick Start Commands:${NC}"
echo "  • LangChain: python -c 'import langchain; print(langchain.__version__)'"
echo "  • CrewAI: crewai --version"
echo "  • LiteLLM: litellm --version"
echo "  • Ollama: ollama --version"
echo "  • Jupyter: jupyter lab"
