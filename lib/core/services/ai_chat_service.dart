import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/imperial/domain/models/imperial_cast_request.dart';
import '../../features/imperial/domain/models/palace_data.dart';
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

  /// Sends the user's Tử Vi chart context to the imperial-ai Edge Function
  /// and returns a structured analysis string.
  static Future<String> analyzeImperial({
    required ImperialCastRequest request,
  }) async {
    final response = await Supabase.instance.client.functions.invoke(
      'imperial-ai',
      body: {
        'spiritId': request.spiritId,
        'arrivalDate': DateFormat('dd/MM/yyyy').format(request.arrivalDay),
        'streamHour': request.streamHour,
        'palaceContext': _buildPalaceContext(),
      },
    );

    final data = response.data as Map<String, dynamic>?;
    if (data == null) throw Exception('Không nhận được phản hồi từ AI');

    if (data.containsKey('error')) {
      throw Exception(data['error']);
    }

    return data['answer'] as String? ?? 'Xin lỗi, có lỗi xảy ra.';
  }

  static String _buildPalaceContext() {
    final buffer = StringBuffer();
    for (final p in kImperialPalaces) {
      buffer.writeln(
        '- ${p.name} | Can: ${p.topLeft} | Chi: ${p.topRight} | '
        'Hành: ${p.element} | Chính tinh: ${p.mainStars.join(", ")} | '
        'Phụ tinh: ${p.minorStars.join(", ")}',
      );
    }
    return buffer.toString().trim();
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
