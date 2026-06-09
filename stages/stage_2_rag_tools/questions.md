1. Hàm @tool decorator được dùng ở đâu?
   - Trả lời: Nó được đặt ngay trên định nghĩa của các hàm (ví dụ: `@tool def search_legal_database(...)`). Decorator này giúp LangChain tự động parse docstring và type hints của hàm để mô tả cho LLM biết công dụng và cách dùng của tool đó.

2. LEGAL_KNOWLEDGE được cấu trúc như thế nào?
   - Trả lời: `LEGAL_KNOWLEDGE` là một mảng (List) chứa các object (Dict). Mỗi object (entry) thường chứa `id` (định danh), `keywords` (các từ khóa để matching) và `text` (nội dung thông tin pháp lý). Đây là một dạng mô phỏng Knowledge Base (RAG) đơn giản bằng in-memory dictionary.

3. LLM được bind với tools ra sao? (Tìm .bind_tools())
   - Trả lời: LLM được bind với tools thông qua phương thức `llm_with_tools = llm.bind_tools(tools)`. Quá trình này sẽ chèn thêm thông số định nghĩa (JSON schema) của các tools vào payload API gửi lên OpenAI/OpenRouter, giúp LLM biết nó có quyền sử dụng các tools này.