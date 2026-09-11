import 'package:flutter/material.dart';
import '../services/auth_controller.dart';
import '../services/favorites_controller.dart';
import '../theme/app_colors.dart';
import 'notifications_screen.dart';
import 'preferences_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Configurações')),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          Card(
              elevation: 0,
              color: AppColors.softGray,
              child: Column(children: [
                ListTile(
                    leading: const Icon(Icons.notifications_none),
                    title: const Text('Notificações'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const NotificationsScreen()))),
                const Divider(height: 1),
                ListTile(
                    leading: const Icon(Icons.restaurant_menu),
                    title: const Text('Preferências alimentares'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PreferencesScreen()))),
                const Divider(height: 1),
                ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Sobre o aplicativo'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => showAboutDialog(
                            context: context,
                            applicationName: 'NutriReceitas',
                            applicationVersion: '1.0.0',
                            children: const [
                              Text(
                                  'Um organizador de receitas para uma rotina mais saudável.')
                            ])),
              ])),
          const SizedBox(height: 20),
          OutlinedButton.icon(
              onPressed: () => _confirmClear(context),
              icon: const Icon(Icons.delete_outline),
              label: const Text('Limpar dados locais')),
        ]),
      );
  Future<void> _confirmClear(BuildContext context) async {
    final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
                title: const Text('Limpar dados locais?'),
                content: const Text(
                    'Isso remove a conta, favoritos e preferências salvas neste dispositivo.'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancelar')),
                  FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Limpar'))
                ]));
    if (confirmed != true) return;
    await AuthController.instance.clearAccountData();
    await FavoritesController.instance.clear();
  }
}
