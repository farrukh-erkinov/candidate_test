import 'package:flutter_test/flutter_test.dart';

import 'package:candidate_test/main.dart';

void main() {
  testWidgets('shows the service history screen', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Детали'), findsOneWidget);
    expect(find.text('История обслуживаний'), findsOneWidget);
    expect(find.text('Vakuum Center'), findsOneWidget);
    expect(find.text('Propan Quvvat'), findsOneWidget);
  });
}
