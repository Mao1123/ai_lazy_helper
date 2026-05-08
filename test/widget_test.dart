import 'package:flutter_test/flutter_test.dart';
import 'package:ai_lazy_helper/main.dart';

void main() {
  testWidgets('App should render', (WidgetTester tester) async {
    await tester.pumpWidget(const AiLazyHelperApp());
    expect(find.text('AI摆烂助手'), findsOneWidget);
  });
}
