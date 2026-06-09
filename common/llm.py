"""Shared LLM factory for all agents.

Uses OpenRouter as an OpenAI-compatible API, so any provider's model
can be selected via the OPENROUTER_MODEL env var.
"""

import os

from langchain_openai import ChatOpenAI

def get_llm(temperature: float = 0.3) -> ChatOpenAI:
    """Return a ChatOpenAI client pointed at OpenRouter."""
    return ChatOpenAI(
        model=os.getenv("OPENROUTER_MODEL", "qwen/qwen3-32b"), 
        openai_api_key=os.getenv("OPENROUTER_API_KEY"),
        openai_api_base="https://api.groq.com/openai/v1",
        temperature=temperature
    )