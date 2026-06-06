import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:task_ui/core/theme/app_theme.dart';
import 'package:task_ui/features/car_details/presentation/pages/car_details_page.dart';

void main() {
  testWidgets('Car details renders title and key actions', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(393 * 3, 852 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.dark, home: const CarDetailsPage()),
    );

    expect(find.text('Детали'), findsOneWidget);
    expect(find.text('Связаться с владельцем'), findsOneWidget);
    expect(find.text('Отправить уведомление'), findsOneWidget);
  });
}
