import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';

const GROQ_API_KEY = Deno.env.get('GROQ_API_KEY')!;
const GROQ_URL = 'https://api.groq.com/openai/v1/chat/completions';
const GROQ_MODEL = 'llama-3.3-70b-versatile';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const { spiritId, arrivalDate, streamHour, palaceContext } = await req.json();

    if (!palaceContext || typeof palaceContext !== 'string') {
      return new Response(
        JSON.stringify({ error: 'palaceContext is required' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
      );
    }

    const trimmedPalaces = String(palaceContext).slice(0, 2000);
    const safeId = String(spiritId ?? '').slice(0, 80);
    const safeDate = String(arrivalDate ?? '').slice(0, 40);
    const safeHour = String(streamHour ?? '').slice(0, 40);

    const systemPrompt =
      `Bạn là chuyên gia diễn giải Tử Vi trong ứng dụng Mystic Cosmos. ` +
      `Nội dung bạn cung cấp chỉ mang tính giải trí và tự khám phá bản thân, không phải tiên tri.\n\n` +
      `Hướng dẫn trả lời:\n` +
      `- Luôn trả lời bằng tiếng Việt\n` +
      `- Cấu trúc câu trả lời thành 5 phần, mỗi phần có tiêu đề in HOA và nội dung 2-3 câu:\n` +
      `  1. TỔNG QUAN MỆNH CỤC\n` +
      `  2. SỰ NGHIỆP & CÔNG DANH (cung Quan Lộc)\n` +
      `  3. TÀI CHÍNH (cung Tài Bạch & Điền Trạch)\n` +
      `  4. TÌNH CẢM & GIA ĐÌNH (cung Phụ Mẫu & Phúc Đức)\n` +
      `  5. LỜI KHUYÊN CÂN BẰNG\n` +
      `- Mỗi phần ngắn gọn, súc tích, tổng độ dài tối đa 350 từ\n` +
      `- Giọng văn ấm áp, sâu sắc, mang tính tham khảo\n\n` +
      `Quy tắc bắt buộc:\n` +
      `- KHÔNG dùng từ tuyệt đối ("sẽ", "chắc chắn", "phải", "luôn luôn"); thay bằng "có thể", "thường", "có xu hướng"\n` +
      `- KHÔNG đưa tiên đoán cụ thể về sự kiện tương lai (ngày cưới, con số, kết quả kinh doanh, sức khoẻ)\n` +
      `- KHÔNG đưa lời khuyên y tế, tài chính, pháp lý hay tâm lý lâm sàng; gợi ý người dùng tham khảo chuyên gia\n` +
      `- KHÔNG khẳng định "đại cát", "đại hung" tuyệt đối; mọi cục diện đều có hai mặt\n` +
      `- KHÔNG phán xét theo giới tính, chủng tộc, tôn giáo hoặc khuynh hướng tính dục\n` +
      `- Luôn trình bày như góc nhìn tham khảo, không phải sự thật khoa học`;

    const userPrompt =
      `Lá số người dùng:\n` +
      `- Định danh: ${safeId}\n` +
      `- Ngày sinh: ${safeDate}\n` +
      `- Giờ sinh: ${safeHour}\n\n` +
      `Bảng an sao (8 cung quanh trung tâm):\n${trimmedPalaces}\n\n` +
      `Hãy diễn giải lá số trên theo đúng cấu trúc 5 phần đã hướng dẫn.`;

    const groqRes = await fetch(GROQ_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${GROQ_API_KEY}`,
      },
      body: JSON.stringify({
        model: GROQ_MODEL,
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user', content: userPrompt },
        ],
        max_tokens: 900,
        temperature: 0.8,
      }),
    });

    const data = await groqRes.json();

    if (!groqRes.ok) {
      throw new Error(data.error?.message ?? 'Groq API error');
    }

    const answer: string =
      data.choices?.[0]?.message?.content ??
      'Xin lỗi, tôi không thể tạo phân tích lúc này. Vui lòng thử lại.';

    return new Response(
      JSON.stringify({ answer }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
    );
  } catch (err) {
    console.error('imperial-ai error:', err);
    return new Response(
      JSON.stringify({ error: String(err) }),
      { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
    );
  }
});
