import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import '../services/nutria_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/chat_bubble.dart';

class NutriaScreen extends StatefulWidget {
  const NutriaScreen({super.key});
  @override
  State<NutriaScreen> createState() => _NutriaScreenState();
}

class _NutriaScreenState extends State<NutriaScreen> {
  final _controller = NutriaController();
  final _input = TextEditingController();
  final _scroll = ScrollController();
  static const _suggestions = [
    'O que posso cozinhar com frango e batata?',
    'Me indique um jantar rápido.',
    'Quero uma receita saudável para o almoço.',
    'Como substituir o leite em uma receita?',
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  void _onChanged() {
    if (!mounted) return;
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(_scroll.position.maxScrollExtent,
            duration: const Duration(milliseconds: 260), curve: Curves.easeOut);
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send([String? suggestion]) {
    final text = suggestion ?? _input.text;
    if (text.trim().isEmpty || _controller.isLoading) return;
    _input.clear();
    _controller.send(text);
  }

  Future<void> _clear() async {
    if (_controller.messages.isEmpty) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar conversa?'),
        content: const Text('Todo o histórico desta sessão será apagado.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Limpar')),
        ],
      ),
    );
    if (confirmed == true) _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final messages = _controller.messages;
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 12, 10),
            child: Row(children: [
              Container(
                width: 48, height: 48,
                decoration: const BoxDecoration(color: AppColors.softGreen, shape: BoxShape.circle),
                child: const Icon(Icons.auto_awesome_outlined, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('NutriIA', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                Text('Sua assistente culinária', style: TextStyle(color: AppColors.muted, fontSize: 13)),
              ])),
              IconButton(onPressed: _clear, tooltip: 'Limpar conversa', icon: const Icon(Icons.delete_outline)),
            ]),
          ),
          Expanded(
            child: ListView(
              controller: _scroll,
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              children: [
                if (messages.isEmpty) ...[
                  ChatBubble(message: ChatMessage(role: ChatMessageRole.assistant, text: 'Olá! Eu sou a NutriIA. 🍃 Estou aqui para ajudar você a descobrir receitas deliciosas e aproveitar melhor seus ingredientes!', createdAt: DateTime.now())),
                  const SizedBox(height: 10),
                  const Text('Experimente perguntar:', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  ..._suggestions.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: OutlinedButton.icon(
                      onPressed: () => _send(item),
                      icon: const Icon(Icons.eco_outlined, size: 17),
                      label: Text(item),
                      style: OutlinedButton.styleFrom(alignment: Alignment.centerLeft, foregroundColor: AppColors.primary, side: const BorderSide(color: AppColors.softGreen), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    ),
                  )),
                ] else ...messages.map((message) => ChatBubble(message: message)),
                if (_controller.isLoading)
                  const Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.only(bottom: 12), child: _TypingIndicator())),
                if (_controller.error != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(14)),
                    child: Row(children: [
                      Expanded(child: Text(_controller.error!, style: TextStyle(color: Colors.red.shade800, fontSize: 13))),
                      TextButton(onPressed: _controller.retry, child: const Text('Tentar novamente')),
                    ]),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Expanded(child: TextField(controller: _input, minLines: 1, maxLines: 5, textInputAction: TextInputAction.newline, decoration: InputDecoration(hintText: 'Pergunte sobre receitas...', filled: true, fillColor: AppColors.softGray, border: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)))),
              const SizedBox(width: 8),
              IconButton.filled(onPressed: _controller.isLoading ? null : _send, style: IconButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white), icon: const Icon(Icons.arrow_upward)),
            ]),
          ),
        ],
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), decoration: BoxDecoration(color: AppColors.softGreen, borderRadius: BorderRadius.circular(18)), child: const Text('NutriIA está pensando...'));
}
