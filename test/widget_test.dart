import 'package:flutter_test/flutter_test.dart';

import 'package:task_ui/main.dart';

void main() {
  testWidgets('App boots and shows the foundation placeholder',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TaskUiApp());

    expect(find.text('Design system tayyor'), findsOneWidget);
  });
}
