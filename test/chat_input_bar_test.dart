import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:task_ui/core/theme/app_theme.dart';
import 'package:task_ui/features/chat/presentation/widgets/chat_input_bar.dart';

void main() {
  testWidgets('Mic button morphs through the record animation without errors', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(393 * 3, 852 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    var recording = false;
    late StateSetter setOuter;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              setOuter = setState;
              return Align(
                alignment: Alignment.bottomCenter,
                child: ChatInputBar(
                  recording: recording,
                  recordingLabel: '0:03',
                  onSend: (_) {},
                  onStartRecording: () => setOuter(() => recording = true),
                  onStopRecording: () => setOuter(() => recording = false),
                  onCancelRecording: () => setOuter(() => recording = false),
                ),
              );
            },
          ),
        ),
      ),
    );

    // Idle: one mic-sized circle, not yet grown.
    Size micCircleSize() {
      final box = tester.renderObject<RenderBox>(
        find.byType(Transform).first,
      );
      return box.size;
    }

    expect(micCircleSize(), const Size(40, 40));

    // Press: grow. Pump partial frames to exercise mid-animation layout.
    setOuter(() => recording = true);
    await tester.pump(); // start
    await tester.pump(const Duration(milliseconds: 80));
    await tester.pump(const Duration(milliseconds: 80));
    await tester.pumpAndSettle();

    // The morph keeps the circle's *layout* box at 40 (it scales visually via
    // Transform), and the recording label is now visible.
    expect(micCircleSize(), const Size(40, 40));
    expect(find.text('0:03'), findsOneWidget);

    // Release: shrink back, settle with no exceptions.
    setOuter(() => recording = false);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 80));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
