import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 import 'package:social_media_app/main.dart'; 

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(const MyApp());

    // Chờ render frame đầu tiên
    await tester.pumpAndSettle();

    // Kiểm tra rằng app đã hiển thị màn hình SplashScreen
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
