"""Authentication middleware for A2A endpoints."""

import os
from fastapi import Request
from fastapi.responses import JSONResponse

def add_auth_middleware(app):
    """Add Bearer token authentication to a FastAPI app."""
    @app.middleware("http")
    async def auth_middleware(request: Request, call_next):
        # Allow discovery and root endpoints
        if request.url.path in ["/.well-known/agent.json", "/"]:
            return await call_next(request)
            
        auth_header = request.headers.get("Authorization")
        expected_key = os.getenv("A2A_API_KEY", "secret-key-123")
        
        if auth_header != f"Bearer {expected_key}":
            return JSONResponse(status_code=401, content={"detail": "Unauthorized"})
            
        return await call_next(request)
