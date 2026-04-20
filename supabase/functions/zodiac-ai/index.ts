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
    const { question, signName, signContext } = await req.json();

    if (!question || question.trim().length === 0) {
      return new Response(
        JSON.stringify({ error: 'Question is required' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
      );
    }

    const trimmedQuestion = question.trim().slice(0, 400);

    const systemPrompt =
      `Bạn là chuyên gia chiêm tinh học Tây phương trong ứng dụng Mystic Cosmos. ` +
      `Nội dung bạn cung cấp chỉ mang tính giải trí và tự khám phá bản thân. ` +
      `Người dùng đang xem trang cung ${signName}.\n\n` +
      `Thông tin về cung ${signName}:\n${signContext}\n\n` +
      `Hướng dẫn trả lời:\n` +
      `- Luôn trả lời bằng tiếng Việt\n` +
      `- Ngắn gọn, tối đa 130 từ\n` +
      `- Chỉ trả lời câu hỏi liên quan đến chiêm tinh học, cung hoàng đạo, tính cách, tình yêu, sự nghiệp\n` +
      `- Nếu câu hỏi không liên quan, lịch sự từ chối và gợi ý hỏi về cung hoàng đạo\n` +
      `- Giọng văn thân thiện, sâu sắc\n` +
      `\n` +
      `Quy tắc bắt buộc:\n` +
      `- KHÔNG dùng các từ tuyệt đối như "sẽ", "chắc chắn", "phải", "luôn luôn"; thay bằng "có thể", "thường", "có xu hướng"\n` +
      `- KHÔNG đưa ra tiên đoán cụ thể về sự kiện tương lai (ngày cưới, con số trúng thưởng, kết quả kinh doanh, tình trạng sức khoẻ...)\n` +
      `- KHÔNG đưa lời khuyên y tế, tài chính, pháp lý hay tâm lý lâm sàng; với các câu hỏi này, gợi ý người dùng tham khảo chuyên gia có chuyên môn\n` +
      `- KHÔNG khẳng định hai người "hợp" hay "không hợp" tuyệt đối; mọi mối quan hệ đều cần giao tiếp và nỗ lực\n` +
      `- KHÔNG phán xét theo giới tính, chủng tộc, tôn giáo hoặc khuynh hướng tính dục\n` +
      `- Luôn trình bày như một góc nhìn tham khảo, không phải sự thật khoa học`;

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
          { role: 'user', content: trimmedQuestion },
        ],
        max_tokens: 280,
        temperature: 0.75,
      }),
    });

    const data = await groqRes.json();

    if (!groqRes.ok) {
      throw new Error(data.error?.message ?? 'Groq API error');
    }

    const answer: string =
      data.choices?.[0]?.message?.content ??
      'Xin lỗi, tôi không thể trả lời lúc này. Vui lòng thử lại.';

    return new Response(
      JSON.stringify({ answer }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
    );
  } catch (err) {
    console.error('zodiac-ai error:', err);
    return new Response(
      JSON.stringify({ error: String(err) }),
      { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
    );
  }
});
