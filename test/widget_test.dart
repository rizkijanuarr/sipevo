import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sipevo/main.dart';

void main() {
  testWidgets('MyApp UI Test', (WidgetTester tester) async {
    // Widget sederhana untuk tes
    Widget testStartingWidget =
        const Scaffold(body: Center(child: Text('Test')));

    // Memperbaiki: Menggunakan MyApp dengan parameter yang diperlukan
    await tester.pumpWidget(MyApp(startingWidget: testStartingWidget));

    // Verifikasi bahwa teks 'Test' muncul
    expect(find.text('Test'), findsOneWidget);
  });
}
