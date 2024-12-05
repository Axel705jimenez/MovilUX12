import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Importa el archivo principal de tu app.
import 'package:movil_ux/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Construir nuestra app y activar un frame.
    // Asegúrate de que el constructor de MyApp es const o elimina 'const' si no lo es.
    await tester.pumpWidget(const MyApp()); // Elimina const si el constructor no es constante

    // Verifica que el contador empiece en 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Toca el ícono '+' y activa un frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifica que el contador se haya incrementado.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
