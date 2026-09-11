import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutri_receitas/screens/search_screen.dart';

void main() {
  testWidgets('busca atualiza os resultados enquanto digita', (tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: SearchScreen())));
    expect(find.textContaining('Resultados ('), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'omelete');
    await tester.pump();
    expect(find.text('Omelete de espinafre'), findsOneWidget);
    expect(find.textContaining('Resultados (1)'), findsOneWidget);
  });

  testWidgets('filtro de dificuldade apresenta opções padronizadas',
      (tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: SearchScreen())));
    await tester.tap(find.text('Dificuldade'));
    await tester.pumpAndSettle();
    expect(find.text('Fácil'), findsOneWidget);
    expect(find.text('Média'), findsOneWidget);
    expect(find.text('Difícil'), findsOneWidget);
    expect(find.text('Médio'), findsNothing);
  });
}
