import 'package:flutter_test/flutter_test.dart';
import 'package:nutri_receitas/main.dart';

void main() {
  testWidgets('abre a tela de autenticação', (tester) async {
    await tester.pumpWidget(const NutriReceitasApp());
    expect(find.text('NutriReceitas'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
    expect(find.text('Ainda não tenho uma conta'), findsOneWidget);
  });

  testWidgets('valida campos obrigatórios no cadastro', (tester) async {
    await tester.pumpWidget(const NutriReceitasApp());
    await tester.tap(find.text('Ainda não tenho uma conta'));
    await tester.pump();
    await tester.tap(find.text('Cadastrar'));
    await tester.pump();
    expect(find.text('Informe seu nome.'), findsOneWidget);
  });
}
