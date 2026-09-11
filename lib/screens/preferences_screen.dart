import 'package:flutter/material.dart';
import '../services/preferences_controller.dart';
import '../theme/app_colors.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Preferências alimentares')),
        body: AnimatedBuilder(
            animation: PreferencesController.instance,
            builder: (context, _) =>
                ListView(padding: const EdgeInsets.all(20), children: [
                  const Text('Escolha o que combina com você',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  const Text('Suas escolhas ficam salvas neste dispositivo.',
                      style: TextStyle(color: AppColors.muted)),
                  const SizedBox(height: 20),
                  ...PreferencesController.options.map((option) => Card(
                      elevation: 0,
                      color: AppColors.softGray,
                      child: CheckboxListTile(
                          value: PreferencesController.instance.selected
                              .contains(option),
                          activeColor: AppColors.primary,
                          title: Text(option),
                          onChanged: (_) =>
                              PreferencesController.instance.toggle(option)))),
                ])),
      );
}
