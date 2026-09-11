import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/auth_controller.dart';
import '../services/profile_controller.dart';
import '../theme/app_colors.dart';
import 'edit_profile_screen.dart';
import 'notifications_screen.dart';
import 'preferences_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _pickPhoto() async {
    final file = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 800, imageQuality: 82);
    if (file != null) {
      await ProfileController.instance.savePhoto(await file.readAsBytes());
    }
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: AnimatedBuilder(
          animation: Listenable.merge(
              [AuthController.instance, ProfileController.instance]),
          builder: (context, _) {
            final auth = AuthController.instance;
            final photo = ProfileController.instance.photoBytes;
            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 35, 16, 35),
              children: [
                Center(
                  child: GestureDetector(
                    onTap: _pickPhoto,
                    child: Stack(children: [
                      CircleAvatar(
                          radius: 68,
                          backgroundColor: AppColors.softGreen,
                          backgroundImage:
                              photo == null ? null : MemoryImage(photo),
                          child: photo == null
                              ? const Icon(Icons.person_outline, size: 70)
                              : null),
                      const Positioned(
                          right: 0,
                          bottom: 0,
                          child: CircleAvatar(
                              radius: 19,
                              backgroundColor: AppColors.primary,
                              child: Icon(Icons.camera_alt_outlined,
                                  color: Colors.white, size: 19))),
                    ]),
                  ),
                ),
                const SizedBox(height: 14),
                Text(auth.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w600)),
                Text(auth.email,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.muted)),
                const SizedBox(height: 28),
                const Text('Minha conta',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                _menuCard(context, [
                  _MenuItem(
                      Icons.person_outline,
                      'Dados pessoais',
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const EditProfileScreen()))),
                  _MenuItem(
                      Icons.restaurant_menu,
                      'Preferências alimentares',
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PreferencesScreen()))),
                  _MenuItem(
                      Icons.notifications_none,
                      'Notificações',
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const NotificationsScreen()))),
                ]),
                const SizedBox(height: 26),
                const Text('Aplicativo',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                _menuCard(context, [
                  _MenuItem(
                      Icons.settings_outlined,
                      'Configurações',
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SettingsScreen()))),
                  _MenuItem(
                      Icons.help_outline,
                      'Ajuda',
                      () => _showInfo(context, 'Ajuda',
                          'Encontre receitas, salve seus favoritos e personalize seu perfil.')),
                  _MenuItem(
                      Icons.info_outline,
                      'Sobre o NutriReceitas',
                      () => _showInfo(context, 'Sobre o NutriReceitas',
                          'Projeto acadêmico desenvolvido com Flutter para organização de receitas.')),
                  _MenuItem(
                      Icons.description_outlined,
                      'Termos de uso',
                      () => _showInfo(context, 'Termos de uso',
                          'Este aplicativo é uma demonstração acadêmica sem backend ou notificações push.')),
                ]),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                    onPressed: AuthController.instance.logout,
                    icon: const Icon(Icons.logout),
                    label: const Text('Sair')),
              ],
            );
          },
        ),
      );

  Widget _menuCard(BuildContext context, List<_MenuItem> items) => Card(
        elevation: 0,
        color: AppColors.softGray,
        child: Column(children: [
          for (var i = 0; i < items.length; i++) ...[
            ListTile(
                leading: Icon(items[i].icon),
                title: Text(items[i].label),
                trailing: const Icon(Icons.chevron_right),
                onTap: items[i].onTap),
            if (i < items.length - 1) const Divider(height: 1),
          ],
        ]),
      );

  void _showInfo(BuildContext context, String title, String message) =>
      showDialog<void>(
          context: context,
          builder: (_) => AlertDialog(
                  title: Text(title),
                  content: Text(message),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Fechar'))
                  ]));
}

class _MenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuItem(this.icon, this.label, this.onTap);
}
