import 'package:flutter/material.dart';
import '../services/notifications_controller.dart';
import '../theme/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Notificações')),
        body: AnimatedBuilder(
            animation: NotificationsController.instance,
            builder: (context, _) =>
                ListView(padding: const EdgeInsets.all(20), children: [
                  const Text('Controle seus avisos',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  const Text('Estas opções ficam salvas localmente.',
                      style: TextStyle(color: AppColors.muted)),
                  const SizedBox(height: 18),
                  _toggle('general', 'Notificações gerais',
                      'Atualizações importantes.'),
                  _toggle('newRecipes', 'Novas receitas',
                      'Receitas recém-adicionadas.'),
                  _toggle('recommended', 'Receitas recomendadas',
                      'Sugestões para você.'),
                  _toggle('reminders', 'Lembretes',
                      'Lembretes para planejar refeições.'),
                ])),
      );
  Widget _toggle(String key, String title, String subtitle) => Card(
      elevation: 0,
      color: AppColors.softGray,
      child: SwitchListTile(
          value: NotificationsController.instance.get(key),
          activeThumbColor: AppColors.primary,
          title: Text(title),
          subtitle: Text(subtitle),
          onChanged: (value) =>
              NotificationsController.instance.set(key, value)));
}
