// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_number_trivia_season_3/core/feature/presentation/number_trivia_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Show Number Trivia title', (WidgetTester tester) async {
    await tester.pumpWidget(NumberTriviaApp());
    expect(find.text('Number Trivia'), findsOneWidget);
  });
}
