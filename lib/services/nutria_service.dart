import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/mock_data.dart';
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
        'A NutriIA ainda não foi conectada ao backend de produção. Configure NUTRIA_API_URL no build do aplicativo.',
      );
    }

    late final http.Response response;
    try {
      response = await _client
          .post(
            Uri.parse(apiUrl),
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode({
              'preferences': preferences,
              'recipeCatalog': recipes
                  .map((recipe) =>
                      '${recipe.name} | categoria: ${recipe.category} | refeição: ${recipe.mealType} | ingredientes: ${recipe.ingredients.join(', ')}')
                  .join('\n'),
              'messages': history
                  .map((message) => {
                        'role': message.isUser ? 'user' : 'assistant',
                        'content': message.text,
                      })
                  .toList(),
            }),
          )
          .timeout(const Duration(seconds: 45));
    } on http.ClientException {
      throw const NutriaException(
        'Não foi possível conectar à NutriIA. Verifique sua conexão e tente novamente.',
      );
    } on TimeoutException {
      throw const NutriaException(
        'A NutriIA demorou mais que o esperado para responder. Tente novamente.',
      );
    } on FormatException {
      throw const NutriaException(
          'O endereço da NutriIA está configurado incorretamente.');
    }

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
      throw const NutriaException(
          'A resposta da NutriIA veio em um formato inválido.');
    }
    return message.trim();
  }
}
