1. LLM được khởi tạo như thế nào? (Tìm hàm get_llm())
   - Trả lời: LLM được khởi tạo thông qua hàm `get_llm()` (thường nằm trong `common/llm.py`). Hàm này sử dụng class `ChatOpenAI` từ `langchain_openai` và nạp các biến môi trường như `OPENROUTER_API_KEY`, `OPENROUTER_MODEL`, và `openai_api_base` trỏ tới OpenRouter/Groq.

2. Message được gửi đến LLM có cấu trúc gì?
   - Trả lời: Message được gửi dưới dạng một List (danh sách) các đối tượng BaseMessage của LangChain, bao gồm `SystemMessage` và `HumanMessage`.

3. Tại sao cần có SystemMessage và HumanMessage?
   - Trả lời: `SystemMessage` dùng để thiết lập bối cảnh, vai trò (role) và quy tắc (rules) chung cho AI (ví dụ: "Bạn là luật sư..."). `HumanMessage` chứa câu hỏi hoặc yêu cầu cụ thể của người dùng. Việc tách biệt giúp LLM hiểu rõ đâu là instruction hệ thống không được vi phạm và đâu là input của user.