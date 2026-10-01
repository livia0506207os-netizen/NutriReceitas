import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/chat_message.dart';

class NutriaException implements Exception {
  final String message;
  const NutriaException(this.message);
  @override
  String toString() => message;
}

class NutriaService {
  NutriaService({http.Client? client}) : _client = client ?? http.Client();

  static const apiUrl = String.fromEnvironment('NUTRIA_API_URL');
  final http.Client _client;

  Future<String> sendMessage({
    required List<ChatMessage> history,
    required String preferences,
  }) async {
    if (apiUrl.isEmpty) {
      throw const NutriaException(
        'A NutriIA ainda não foi configurada. Defina NUTRIA_API_URL para conectar o backend.',
      );
    }

    final response = await _client
        .post(
          Uri.parse(apiUrl),
          headers: const {'Content-Type': 'application/json'},
          body: jsonEncode({
            'preferences': preferences,
            'messages': history
                .map((message) => {
                      'role': message.isUser ? 'user' : 'assistant',
                      'content': message.text,
                    })
                .toList(),
          }),
        )
        .timeout(const Duration(seconds: 45));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      String detail = 'Não foi possível obter uma resposta agora.';
      try {
        final body = jsonDecode(response.body);
        if (body is Map && body['error'] is String) detail = body['error'];
      } catch (_) {}
      throw NutriaException(detail);
    }

    final body = jsonDecode(response.body);
    final message = body is Map ? body['message'] : null;
    if (message is! String || message.trim().isEmpty) {
      throw const NutriaException('A resposta da NutriIA veio em um formato inválido.');
    }
    return message.trim();
  }
}
