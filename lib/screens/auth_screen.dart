import 'package:flutter/material.dart';

import '../services/auth_controller.dart';
import '../theme/app_colors.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmation = TextEditingController();
  bool _registering = false;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmation.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    final result = _registering
        ? await AuthController.instance.register(
            name: _name.text,
            email: _email.text,
            password: _password.text,
          )
        : await AuthController.instance.login(
            email: _email.text,
            password: _password.text,
          );
    if (!mounted) return;
    setState(() {
      _loading = false;
      _error = result;
    });
  }

  String? _required(String? value, String message) =>
      value == null || value.trim().isEmpty ? message : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.eco_outlined,
                        size: 64, color: AppColors.primary),
                    const SizedBox(height: 10),
                    const Text('NutriReceitas',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text(
                        _registering
                            ? 'Crie sua conta'
                            : 'Entre para continuar',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.muted)),
                    const SizedBox(height: 30),
                    if (_registering) ...[
                      TextFormField(
                        controller: _name,
                        decoration: _decoration('Nome', Icons.person_outline),
                        validator: (v) => _required(v, 'Informe seu nome.'),
                      ),
                      const SizedBox(height: 14),
                    ],
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _decoration('E-mail', Icons.email_outlined),
                      validator: (v) {
                        final required = _required(v, 'Informe seu e-mail.');
                        if (required != null) return required;
                        return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                .hasMatch(v!.trim())
                            ? null
                            : 'Digite um e-mail válido.';
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _password,
                      obscureText: true,
                      decoration: _decoration('Senha', Icons.lock_outline),
                      validator: (v) => v == null || v.length < 6
                          ? 'Use pelo menos 6 caracteres.'
                          : null,
                    ),
                    if (_registering) ...[
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _confirmation,
                        obscureText: true,
                        decoration: _decoration(
                            'Confirmar senha', Icons.lock_reset_outlined),
                        validator: (v) => v != _password.text
                            ? 'As senhas não conferem.'
                            : null,
                      ),
                    ],
                    if (_error != null) ...[
                      const SizedBox(height: 14),
                      Text(_error!,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center),
                    ],
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 50,
                      child: FilledButton(
                        onPressed: _loading ? null : _submit,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        child: _loading
                            ? const CircularProgressIndicator()
                            : Text(_registering ? 'Cadastrar' : 'Entrar'),
                      ),
                    ),
                    TextButton(
                      onPressed: _loading
                          ? null
                          : () => setState(() {
                                _registering = !_registering;
                                _error = null;
                              }),
                      child: Text(_registering
                          ? 'Já tenho uma conta'
                          : 'Ainda não tenho uma conta'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _decoration(String label, IconData icon) => InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      );
}
