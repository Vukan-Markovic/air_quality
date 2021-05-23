import 'package:flutter_test/flutter_test.dart';
import 'package:air_quality/main.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
  });
}
