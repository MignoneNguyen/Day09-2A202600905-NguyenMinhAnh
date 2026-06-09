# Câu Hỏi Ôn Tập - Stage 5 (Distributed A2A)

**1. Khi nào nên dùng single agent thay vì multi-agent?**
- **Trả lời:** Bạn nên dùng single agent khi bài toán có phạm vi hẹp (narrow scope), logic tuyến tính, số lượng tools ít và không cần chuyên môn hoá sâu sắc. Việc dùng single agent giúp giảm độ trễ (latency), tiết kiệm chi phí gọi LLM và dễ dàng debug. Multi-agent chỉ thực sự cần thiết khi bài toán quá phức tạp, đòi hỏi nhiều domains kiến thức khác nhau (VD: Thuế, Pháp luật, Compliance), và có thể chia nhỏ để thực thi song song (parallel execution).

**2. Ưu điểm của A2A protocol so với gRPC hoặc REST thông thường?**
- **Trả lời:** A2A Protocol là chuẩn giao tiếp (Agent-to-Agent) được thiết kế chuyên biệt cho các AI Agents. Ưu điểm lớn nhất của nó là tiêu chuẩn hoá Agent Card (giúp agent tự quảng bá metadata và capabilities), hỗ trợ Multipart Messages và Tracing nguyên bản (chuyền `context_id` và `trace_id` qua từng node). Khác với REST/gRPC vốn chỉ gửi nhận data thô, A2A giúp các agent tự "hiểu" được khả năng của nhau và tự động chain các task một cách ngữ nghĩa.

**3. Làm thế nào để prevent infinite delegation loops trong A2A?**
- **Trả lời:** Trong hệ thống Multi-Agent A2A, infinite delegation loop xảy ra khi Agent A nhờ Agent B, Agent B lại nhờ ngược lại Agent A vòng quanh. Để ngăn chặn, ta dùng 2 cách: (1) Thiết lập giới hạn chiều sâu tối đa (ví dụ: `MAX_DELEGATION_DEPTH = 3`). Bất cứ message nào vượt quá độ sâu này sẽ bị từ chối tự động. (2) Track lịch sử các task (`reference_task_ids` hoặc Trace) để agent phát hiện ra nó đang nhận lại chính request mà nó đã gửi đi.

**4. Tại sao cần Registry service? Có thể hardcode URLs không?**
- **Trả lời:** Registry Service (Service Discovery) giúp hệ thống linh hoạt và có khả năng scale (phóng to/thu nhỏ). Các agents khi khởi động sẽ tự báo cáo địa chỉ IP/Port và capabilities cho Registry. Nếu ta hardcode URLs, khi một Agent đổi cổng, crash, hoặc ta muốn chạy 3 instance của Tax Agent để load-balance, ta sẽ phải sửa code thủ công ở khắp mọi nơi. Với Registry, Customer Agent chỉ cần hỏi "Ai có thể xử lý việc thuế?", Registry sẽ tự động trả về địa chỉ của Tax Agent đang rảnh.
