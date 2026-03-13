# LLM Installation & Configuration Guide

**Last Updated:** 2026-03-13

Complete guide for installing and configuring Large Language Models for local and cloud-based AI development.

---

## Table of Contents

1. [Local LLM Runtime (Ollama)](#local-llm-runtime-ollama)
2. [Cloud LLM APIs](#cloud-llm-apis)
3. [LLM Frameworks](#llm-frameworks)
4. [Model Routers](#model-routers)
5. [Vector Databases](#vector-databases)
6. [Embeddings](#embeddings)
7. [Best Practices](#best-practices)

---

## Local LLM Runtime (Ollama)

### Installation

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

### Basic Usage

```bash
# Pull a model
ollama pull llama2
ollama pull mistral
ollama pull codellama

# Run a model
ollama run llama2

# List installed models
ollama list

# Remove a model
ollama rm llama2
```

### Popular Models (2026)

| Model | Size | Use Case | Command |
|-------|------|----------|---------|
| Llama 3.1 | 8B-70B | General purpose | `ollama pull llama3.1` |
| Mistral | 7B | Fast, efficient | `ollama pull mistral` |
| CodeLlama | 7B-34B | Code generation | `ollama pull codellama` |
| Mixtral | 8x7B | MoE, high quality | `ollama pull mixtral` |
| Phi-3 | 3.8B | Small, fast | `ollama pull phi3` |
| Gemma 2 | 9B-27B | Google's model | `ollama pull gemma2` |
| Qwen 2.5 | 7B-72B | Multilingual | `ollama pull qwen2.5` |
| DeepSeek Coder | 6.7B-33B | Code specialist | `ollama pull deepseek-coder` |

### API Usage

```bash
# Start Ollama server (runs on port 11434)
ollama serve

# API endpoint
curl http://localhost:11434/api/generate -d '{
  "model": "llama2",
  "prompt": "Why is the sky blue?"
}'
```

### Python Integration

```python
import requests

def query_ollama(prompt, model="llama2"):
    response = requests.post(
        "http://localhost:11434/api/generate",
        json={"model": model, "prompt": prompt, "stream": False}
    )
    return response.json()["response"]

result = query_ollama("Explain quantum computing")
print(result)
```

---

## Cloud LLM APIs

### Anthropic (Claude)

```bash
export ANTHROPIC_API_KEY="sk-ant-..."
```

**Python:**
```python
from anthropic import Anthropic

client = Anthropic(api_key="sk-ant-...")
message = client.messages.create(
    model="claude-sonnet-4",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Hello, Claude"}]
)
print(message.content)
```

**Models:**
- `claude-opus-4` - Most capable
- `claude-sonnet-4` - Balanced
- `claude-haiku-4` - Fast, efficient

---

### OpenAI (GPT)

```bash
export OPENAI_API_KEY="sk-..."
```

**Python:**
```python
from openai import OpenAI

client = OpenAI(api_key="sk-...")
response = client.chat.completions.create(
    model="gpt-4-turbo",
    messages=[{"role": "user", "content": "Hello, GPT"}]
)
print(response.choices[0].message.content)
```

**Models:**
- `gpt-4-turbo` - Most capable
- `gpt-4` - Standard
- `gpt-3.5-turbo` - Fast, cheap

---

### Google (Gemini)

```bash
export GEMINI_API_KEY="..."
```

**Python:**
```python
import google.generativeai as genai

genai.configure(api_key="...")
model = genai.GenerativeModel('gemini-pro')
response = model.generate_content("Hello, Gemini")
print(response.text)
```

**Models:**
- `gemini-2.0-flash-exp` - Latest, fastest
- `gemini-1.5-pro` - Most capable
- `gemini-1.5-flash` - Fast, efficient

---

### OpenRouter (Multi-Provider)

```bash
export OPENROUTER_API_KEY="sk-or-..."
```

**Features:**
- Access 100+ models through one API
- Automatic fallbacks
- Cost optimization
- Rate limit handling

**Python:**
```python
import openai

client = openai.OpenAI(
    base_url="https://openrouter.ai/api/v1",
    api_key="sk-or-..."
)

response = client.chat.completions.create(
    model="anthropic/claude-sonnet-4",
    messages=[{"role": "user", "content": "Hello"}]
)
```

---

## LLM Frameworks

### LangChain

```bash
pip install langchain langchain-openai langchain-anthropic langchain-google-genai
```

**Basic Usage:**
```python
from langchain_anthropic import ChatAnthropic
from langchain_core.messages import HumanMessage

llm = ChatAnthropic(model="claude-sonnet-4")
response = llm.invoke([HumanMessage(content="Hello")])
print(response.content)
```

**Chains:**
```python
from langchain.chains import LLMChain
from langchain.prompts import PromptTemplate

template = "Tell me a {adjective} joke about {topic}"
prompt = PromptTemplate(template=template, input_variables=["adjective", "topic"])
chain = LLMChain(llm=llm, prompt=prompt)

result = chain.run(adjective="funny", topic="programming")
```

---

### CrewAI

```bash
pip install crewai crewai-tools
```

**Multi-Agent Setup:**
```python
from crewai import Agent, Task, Crew

researcher = Agent(
    role="Researcher",
    goal="Research and analyze topics",
    backstory="Expert researcher with deep knowledge",
    verbose=True
)

writer = Agent(
    role="Writer",
    goal="Write engaging content",
    backstory="Professional content writer",
    verbose=True
)

task = Task(
    description="Research AI trends and write a summary",
    agent=researcher
)

crew = Crew(agents=[researcher, writer], tasks=[task])
result = crew.kickoff()
```

---

### LiteLLM

```bash
pip install litellm
```

**Unified API:**
```python
from litellm import completion

# Works with any provider
response = completion(
    model="claude-sonnet-4",
    messages=[{"role": "user", "content": "Hello"}]
)

# Automatic fallbacks
response = completion(
    model="gpt-4",
    messages=[{"role": "user", "content": "Hello"}],
    fallbacks=["claude-sonnet-4", "gemini-pro"]
)
```

**Proxy Server:**
```bash
litellm --model gpt-4
# Access at http://localhost:4000
```

---

## Model Routers

### 9router

**Intelligent model routing based on query complexity**

```bash
# Configuration in opencode.json
{
  "models": {
    "default": "9router/kr/claude-sonnet-4.5",
    "routing": {
      "simple": "gemini-2.0-flash-exp",
      "medium": "claude-sonnet-4",
      "complex": "claude-opus-4"
    }
  }
}
```

---

## Vector Databases

### Qdrant

```bash
# Docker
docker run -p 6333:6333 qdrant/qdrant

# Python client
pip install qdrant-client
```

**Usage:**
```python
from qdrant_client import QdrantClient
from qdrant_client.models import Distance, VectorParams

client = QdrantClient("localhost", port=6333)

client.create_collection(
    collection_name="documents",
    vectors_config=VectorParams(size=384, distance=Distance.COSINE)
)

client.upsert(
    collection_name="documents",
    points=[
        {"id": 1, "vector": [0.1, 0.2, ...], "payload": {"text": "..."}}
    ]
)
```

---

### ChromaDB

```bash
pip install chromadb
```

**Usage:**
```python
import chromadb

client = chromadb.Client()
collection = client.create_collection("documents")

collection.add(
    documents=["Document 1", "Document 2"],
    ids=["id1", "id2"]
)

results = collection.query(
    query_texts=["search query"],
    n_results=5
)
```

---

### FAISS

```bash
pip install faiss-cpu
```

**Usage:**
```python
import faiss
import numpy as np

dimension = 384
index = faiss.IndexFlatL2(dimension)

vectors = np.random.random((1000, dimension)).astype('float32')
index.add(vectors)

query = np.random.random((1, dimension)).astype('float32')
distances, indices = index.search(query, k=5)
```

---

## Embeddings

### sentence-transformers

```bash
pip install sentence-transformers
```

**Usage:**
```python
from sentence_transformers import SentenceTransformer

model = SentenceTransformer('all-MiniLM-L6-v2')
embeddings = model.encode([
    "This is a sentence",
    "This is another sentence"
])
```

**Popular Models:**
- `all-MiniLM-L6-v2` - Fast, 384 dimensions
- `all-mpnet-base-v2` - High quality, 768 dimensions
- `multi-qa-mpnet-base-dot-v1` - Question answering

---

### OpenAI Embeddings

```python
from openai import OpenAI

client = OpenAI()
response = client.embeddings.create(
    model="text-embedding-3-small",
    input="Text to embed"
)
embedding = response.data[0].embedding
```

---

## Best Practices

### Model Selection

**Local vs Cloud:**
- **Local (Ollama):** Privacy, no API costs, offline access
- **Cloud:** Higher quality, faster, no hardware requirements

**Model Size:**
- **3-7B:** Fast, good for simple tasks
- **13-34B:** Balanced quality/speed
- **70B+:** Highest quality, slower

---

### Cost Optimization

1. **Use model routers** - Route simple queries to cheaper models
2. **Cache responses** - Store common queries
3. **Batch requests** - Reduce API calls
4. **Use streaming** - Better UX, same cost
5. **Monitor usage** - Track costs with LiteLLM/Helicone

---

### Performance Optimization

1. **Use smaller models** when possible
2. **Enable streaming** for better perceived performance
3. **Implement caching** for repeated queries
4. **Use embeddings** for semantic search
5. **Batch similar requests** together

---

### Security

1. **Never commit API keys** - Use environment variables
2. **Rotate keys regularly**
3. **Use rate limiting** to prevent abuse
4. **Implement input validation**
5. **Monitor for anomalies**

---

### Environment Variables Template

```bash
# ~/.config/opencode/.env

# Anthropic
export ANTHROPIC_API_KEY="sk-ant-..."

# OpenAI
export OPENAI_API_KEY="sk-..."

# Google
export GEMINI_API_KEY="..."

# OpenRouter
export OPENROUTER_API_KEY="sk-or-..."

# Vector Databases
export QDRANT_URL="http://localhost:6333"
export QDRANT_API_KEY="..."

# Observability
export LANGSMITH_API_KEY="..."
export AGENTOPS_API_KEY="..."
```

---

## Troubleshooting

### Ollama Issues

```bash
# Check if Ollama is running
curl http://localhost:11434/api/tags

# Restart Ollama
sudo systemctl restart ollama

# Check logs
journalctl -u ollama -f
```

### API Rate Limits

```python
# Implement exponential backoff
import time
from openai import OpenAI, RateLimitError

client = OpenAI()

def call_with_retry(func, max_retries=3):
    for i in range(max_retries):
        try:
            return func()
        except RateLimitError:
            wait = 2 ** i
            time.sleep(wait)
    raise Exception("Max retries exceeded")
```

---

## Additional Resources

- [Ollama Documentation](https://ollama.com/docs)
- [LangChain Documentation](https://python.langchain.com/)
- [LiteLLM Documentation](https://docs.litellm.ai/)
- [OpenRouter Models](https://openrouter.ai/models)
- [Hugging Face Models](https://huggingface.co/models)

---

**Generated:** 2026-03-13  
**Maintained by:** OpenCode Community
