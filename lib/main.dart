import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/app_shell.dart';
import 'screens/auth_screen.dart';
import 'services/auth_controller.dart';
import 'services/favorites_controller.dart';
import 'services/notifications_controller.dart';
import 'services/preferences_controller.dart';
import 'services/profile_controller.dart';
import 'theme/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthController.instance.init();
  await FavoritesController.instance.init();
  await ProfileController.instance.init();
  await PreferencesController.instance.init();
  await NotificationsController.instance.init();

  runApp(const NutriReceitasApp());
}

class NutriReceitasApp extends StatelessWidget {
  const NutriReceitasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NutriReceitas',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: AppColors.background,
        ),
        textTheme: GoogleFonts.jostTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AuthController.instance,
      builder: (context, _) => AuthController.instance.isLoggedIn
          ? const AppShell()
          : const AuthScreen(),
    );
  }
}
