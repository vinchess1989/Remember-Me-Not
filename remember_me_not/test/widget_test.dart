import 'package:flutter_test/flutter_test.dart';
import 'package:remember_me_not/main.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RememberMeNotApp());

    // Verify that it builds without crashing.
    expect(find.byType(RememberMeNotApp), findsOneWidget);
  });
}
