import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:draggable_expandable_widget/main.dart';

void main() {
  testWidgets('draggable expandable widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final closeButton = find.byKey(const ValueKey<String>("closeWidget"));
    final openButton = find.byKey(const ValueKey<String>("openWidget"));
    final Finder widget1 = find.byKey(const ValueKey("opened1"),);
    final Finder widget2 = find.byKey(const ValueKey("opened2"),);
    final Finder widget3 = find.byKey(const ValueKey("opened3"),);
    final Finder widget4 = find.byKey(const ValueKey("opened4"),);
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(widget1, findsNothing);
    expect(widget2, findsNothing);
    expect(widget3, findsNothing);
    expect(widget4, findsNothing);


    // Tap the open and trigger a frame.
    await tester.tap(openButton);
    await tester.pump();

    // Verify that our children have visible.
    expect(widget1, findsOneWidget);
    expect(widget2, findsOneWidget);
    expect(widget3, findsOneWidget);
    expect(widget4, findsOneWidget);


    // Tap the open and trigger a frame.
    await tester.tap(closeButton);
    await tester.pump();

    // Verify that our children have invisible.
    expect(widget1, findsNothing);
    expect(widget2, findsNothing);
    expect(widget3, findsNothing);
    expect(widget4, findsNothing);

  });
}
