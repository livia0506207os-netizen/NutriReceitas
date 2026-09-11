import 'package:flutter/material.dart';
import '../services/auth_controller.dart';
import '../theme/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController name =
      TextEditingController(text: AuthController.instance.name);
  late final TextEditingController email =
      TextEditingController(text: AuthController.instance.email);
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    name.dispose();
    email.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (!formKey.currentState!.validate()) return;
    await AuthController.instance
        .updateUser(name: name.text, email: email.text);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Dados pessoais')),
        body: Form(
            key: formKey,
            child: ListView(padding: const EdgeInsets.all(20), children: [
              TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                      labelText: 'Nome',
                      prefixIcon: Icon(Icons.person_outline)),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Informe seu nome.'
                      : null),
              const SizedBox(height: 16),
              TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: 'E-mail',
                      prefixIcon: Icon(Icons.email_outlined)),
                  validator: (v) => v == null ||
                          !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                              .hasMatch(v.trim())
                      ? 'Digite um e-mail válido.'
                      : null),
              const SizedBox(height: 28),
              FilledButton.icon(
                  onPressed: save,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Salvar alterações'),
                  style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary)),
            ])),
      );
}
