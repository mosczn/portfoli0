import 'package:flame/game.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bingy/main.dart';

void main() {
  testWidgets('BingyApp builds and mounts the game widget', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BingyApp());
    await tester.pump();

    expect(find.byWidgetPredicate((widget) => widget is GameWidget), findsOneWidget);
  });
}
