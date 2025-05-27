# LLM Integration Guidelines

## API Providers

Bray.Doc's projects integrate with multiple LLM providers:

### Claude (Anthropic) - Primary
```python
# ABOUTME: Claude API client setup
# Standard configuration for Anthropic Claude
from anthropic import Anthropic

client = Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])
```

### OpenAI - Secondary
```python
# ABOUTME: OpenAI client setup  
# Fallback or specific use cases
from openai import OpenAI

client = OpenAI(api_key=os.environ["OPENAI_API_KEY"])
```

## Environment Configuration

Always use environment variables for API keys:
```bash
# .env file
ANTHROPIC_API_KEY=your_key_here
OPENAI_API_KEY=your_key_here
OLLAMA_BASE_URL=http://localhost:11434  # For local models
```

## Error Handling

### Retry Logic
```python
import time
from typing import Optional

def call_llm_with_retry(prompt: str, max_retries: int = 3) -> Optional[str]:
    """Call LLM with exponential backoff retry."""
    for attempt in range(max_retries):
        try:
            response = client.messages.create(
                model="claude-3-opus-20240229",
                max_tokens=1000,
                messages=[{"role": "user", "content": prompt}]
            )
            return response.content[0].text
        except Exception as e:
            if attempt == max_retries - 1:
                logger.error(f"LLM call failed after {max_retries} attempts: {e}")
                raise
            wait_time = 2 ** attempt
            logger.warning(f"LLM call failed, retrying in {wait_time}s: {e}")
            time.sleep(wait_time)
```

### Rate Limiting
```python
from functools import wraps
import time

class RateLimiter:
    def __init__(self, calls_per_minute: int):
        self.calls_per_minute = calls_per_minute
        self.calls = []
    
    def __call__(self, func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            now = time.time()
            self.calls = [c for c in self.calls if c > now - 60]
            
            if len(self.calls) >= self.calls_per_minute:
                sleep_time = 60 - (now - self.calls[0])
                time.sleep(sleep_time)
            
            self.calls.append(time.time())
            return func(*args, **kwargs)
        return wrapper

@RateLimiter(calls_per_minute=50)
def call_llm(prompt: str) -> str:
    # LLM call implementation
    pass
```

## Prompt Engineering

### Structure Templates
```python
# ABOUTME: Prompt template system
# Consistent prompt formatting across projects
class PromptTemplate:
    def __init__(self, template: str):
        self.template = template
    
    def format(self, **kwargs) -> str:
        return self.template.format(**kwargs)

# Example templates
ANALYSIS_PROMPT = PromptTemplate("""
Analyze the following {data_type}:

{content}

Provide a structured analysis focusing on:
1. Key findings
2. Potential issues
3. Recommendations

Format your response as JSON.
""")

CODE_REVIEW_PROMPT = PromptTemplate("""
Review the following {language} code:

```{language}
{code}
```

Focus on:
- Code quality
- Potential bugs
- Performance issues
- Security concerns
""")
```

### System Prompts
```python
SYSTEM_PROMPTS = {
    "analyst": "You are a senior data analyst with expertise in pattern recognition and statistical analysis.",
    "developer": "You are an experienced software developer focused on clean, maintainable code and best practices.",
    "reviewer": "You are a thorough code reviewer who identifies bugs, security issues, and opportunities for improvement."
}
```

## Response Parsing

### Structured Output
```python
import json
from typing import Dict, Any
from pydantic import BaseModel, ValidationError

class LLMResponse(BaseModel):
    """Base model for structured LLM responses."""
    success: bool
    data: Dict[str, Any]
    confidence: float
    reasoning: str

def parse_llm_response(response: str) -> LLMResponse:
    """Parse and validate LLM response."""
    try:
        # Try to extract JSON from response
        json_start = response.find('{')
        json_end = response.rfind('}') + 1
        json_str = response[json_start:json_end]
        
        data = json.loads(json_str)
        return LLMResponse(**data)
    except (json.JSONDecodeError, ValidationError) as e:
        logger.error(f"Failed to parse LLM response: {e}")
        # Fallback parsing logic
        return LLMResponse(
            success=False,
            data={},
            confidence=0.0,
            reasoning="Failed to parse response"
        )
```

## Cost Management

### Token Counting
```python
import tiktoken

def count_tokens(text: str, model: str = "gpt-4") -> int:
    """Count tokens for a given text and model."""
    encoding = tiktoken.encoding_for_model(model)
    return len(encoding.encode(text))

def estimate_cost(prompt_tokens: int, completion_tokens: int, model: str) -> float:
    """Estimate API call cost."""
    rates = {
        "gpt-4": {"prompt": 0.03, "completion": 0.06},
        "gpt-3.5-turbo": {"prompt": 0.001, "completion": 0.002},
        "claude-3-opus": {"prompt": 0.015, "completion": 0.075}
    }
    
    rate = rates.get(model, {"prompt": 0.01, "completion": 0.03})
    cost = (prompt_tokens * rate["prompt"] + completion_tokens * rate["completion"]) / 1000
    return cost
```

### Usage Tracking
```python
class LLMUsageTracker:
    def __init__(self):
        self.usage = []
    
    def track(self, model: str, prompt_tokens: int, completion_tokens: int, cost: float):
        """Track LLM usage for monitoring."""
        self.usage.append({
            "timestamp": time.time(),
            "model": model,
            "prompt_tokens": prompt_tokens,
            "completion_tokens": completion_tokens,
            "cost": cost
        })
    
    def get_daily_cost(self) -> float:
        """Get total cost for current day."""
        today_start = time.time() - (time.time() % 86400)
        return sum(u["cost"] for u in self.usage if u["timestamp"] >= today_start)
```

## Multi-Model Strategies

### Model Selection
```python
class ModelSelector:
    """Select appropriate model based on task requirements."""
    
    MODELS = {
        "fast": "gpt-3.5-turbo",
        "balanced": "claude-3-sonnet",
        "quality": "claude-3-opus",
        "local": "llama2:70b"
    }
    
    def select_model(self, task_type: str, priority: str = "balanced") -> str:
        """Select model based on task and priority."""
        task_configs = {
            "code_generation": "quality",
            "summarization": "balanced",
            "classification": "fast",
            "analysis": "quality"
        }
        
        priority = task_configs.get(task_type, priority)
        return self.MODELS.get(priority, self.MODELS["balanced"])
```

### Fallback Chain
```python
async def call_with_fallback(prompt: str, models: List[str]) -> Optional[str]:
    """Try multiple models with fallback."""
    for model in models:
        try:
            if model.startswith("claude"):
                return await call_claude(prompt, model)
            elif model.startswith("gpt"):
                return await call_openai(prompt, model)
            elif model.startswith("llama"):
                return await call_ollama(prompt, model)
        except Exception as e:
            logger.warning(f"Model {model} failed: {e}")
            continue
    
    raise Exception("All models failed")
```

## Testing LLM Integrations

### Mock Responses
```python
class MockLLMClient:
    """Mock LLM client for testing."""
    
    def __init__(self, responses: Dict[str, str]):
        self.responses = responses
        self.call_count = 0
    
    def complete(self, prompt: str) -> str:
        self.call_count += 1
        # Return mock response based on prompt content
        for key, response in self.responses.items():
            if key in prompt:
                return response
        return "Default mock response"
```

### Integration Tests
```python
@pytest.mark.integration
def test_llm_error_handling():
    """Test LLM integration error handling."""
    with patch.dict(os.environ, {"ANTHROPIC_API_KEY": "test_key"}):
        # Test rate limiting
        # Test timeout handling  
        # Test malformed responses
        pass
```

## Best Practices

1. **Always set temperature**: Be explicit about randomness
2. **Use system prompts**: Set context and behavior
3. **Validate responses**: Never trust LLM output blindly
4. **Log everything**: Track usage, errors, and performance
5. **Cache when possible**: Reuse responses for identical prompts
6. **Set timeouts**: Prevent hanging on slow responses
7. **Handle partial responses**: Stream for long outputs
8. **Version prompts**: Track prompt changes over time