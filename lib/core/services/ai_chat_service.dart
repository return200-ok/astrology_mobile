import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/oracle/domain/models/oracle_sign.dart';

class AiChatService {
  const AiChatService._();

  /// Sends [question] to the zodiac-ai Edge Function with the sign's context
  /// as the system prompt. Returns the AI's answer string.
  static Future<String> ask({
    required String question,
    required OracleSign sign,
  }) async {
    final response = await Supabase.instance.client.functions.invoke(
      'zodiac-ai',
      body: {
        'question': question,
        'signName': sign.name,
        'signContext': _buildContext(sign),
      },
    );

    final data = response.data as Map<String, dynamic>?;
    if (data == null) throw Exception('Không nhận được phản hồi từ AI');

    if (data.containsKey('error')) {
      throw Exception(data['error']);
    }

    return data['answer'] as String? ?? 'Xin lỗi, có lỗi xảy ra.';
  }

  // Build a concise context string from the sign's model data
  static String _buildContext(OracleSign sign) {
    return '''Nguyên tố: ${sign.element} | Phẩm chất: ${sign.modality}
Tổng quan: ${sign.summary}
Nam — Tính cách: ${sign.male.personality}
Nữ — Tính cách: ${sign.female.personality}
Decan 1 (${sign.decan1.dateRange}, ${sign.decan1.planetInfluence}): ${sign.decan1.description}
Decan 2 (${sign.decan2.dateRange}, ${sign.decan2.planetInfluence}): ${sign.decan2.description}
Decan 3 (${sign.decan3.dateRange}, ${sign.decan3.planetInfluence}): ${sign.decan3.description}
Mặt Trời (${sign.sunLayer.essence}): ${sign.sunLayer.description}
Mặt Trăng (${sign.moonLayer.essence}): ${sign.moonLayer.description}
Mọọc (${sign.risingLayer.essence}): ${sign.risingLayer.description}''';
  }
}
