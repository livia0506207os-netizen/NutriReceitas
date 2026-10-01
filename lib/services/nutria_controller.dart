import 'package:flutter/foundation.dart';

import '../models/chat_message.dart';
import 'nutria_service.dart';
import 'preferences_controller.dart';

class NutriaController extends ChangeNotifier {
  NutriaController({NutriaService? service}) : _service = service ?? NutriaService();

  final NutriaService _service;
  final List<ChatMessage> _messages = [];
  bool isLoading = false;
  String? error;
  String? _lastQuestion;

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  Future<void> send(String text) async {
    final question = text.trim();
    if (question.isEmpty || isLoading) return;
    error = null;
    _lastQuestion = question;
    _messages.add(ChatMessage(
      role: ChatMessageRole.user,
      text: question,
      createdAt: DateTime.now(),
    ));
    isLoading = true;
    notifyListeners();

    try {
      final answer = await _service.sendMessage(
        history: _messages,
        preferences: PreferencesController.instance.selected.join(', '),
      );
      _messages.add(ChatMessage(
        role: ChatMessageRole.assistant,
        text: answer,
        createdAt: DateTime.now(),
      ));
    } catch (exception) {
      error = exception.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> retry() async {
    final question = _lastQuestion;
    if (question == null) return;
    if (_messages.isNotEmpty && _messages.last.isUser) {
      _messages.removeLast();
    }
    await send(question);
  }

  void clear() {
    _messages.clear();
    error = null;
    _lastQuestion = null;
    notifyListeners();
  }
}
