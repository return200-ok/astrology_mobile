import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';

const GEMINI_API_KEY = Deno.env.get('GEMINI_API_KEY')!;
const GEMINI_URL =
  `https://generativelanguage.googleapis.com/v1/models/gemini-2.0-flash:generateContent?key=${GEMINI_API_KEY}`;

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

serve(async (req) => {
  // Handle CORS preflight
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

    // Limit input length to control token usage
    const trimmedQuestion = question.trim().slice(0, 400);

    const systemPrompt =
      `Bạn là chuyên gia chiêm tinh học Tây phương trong ứng dụng Mystic Cosmos. ` +
      `Người dùng đang xem trang cung ${signName}.\n\n` +
      `Thông tin về cung ${signName}:\n${signContext}\n\n` +
      `Hướng dẫn trả lời:\n` +
      `- Luôn trả lời bằng tiếng Việt\n` +
      `- Ngắn gọn, tối đa 130 từ\n` +
      `- Chỉ trả lời câu hỏi liên quan đến chiêm tinh học, cung hoàng đạo, tính cách, tình yêu, sự nghiệp\n` +
      `- Nếu câu hỏi không liên quan, lịch sự từ chối và gợi ý hỏi về cung hoàng đạo\n` +
      `- Giọng văn thân thiện, sâu sắc`;

    const fullPrompt = `${systemPrompt}\n\nCâu hỏi của người dùng: ${trimmedQuestion}`;

    const geminiRes = await fetch(GEMINI_URL, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        contents: [{ parts: [{ text: fullPrompt }] }],
        generationConfig: {
          maxOutputTokens: 280,
          temperature: 0.75,
        },
      }),
    });

    const data = await geminiRes.json();

    if (!geminiRes.ok) {
      throw new Error(data.error?.message ?? 'Gemini API error');
    }

    const answer: string =
      data.candidates?.[0]?.content?.parts?.[0]?.text ??
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
