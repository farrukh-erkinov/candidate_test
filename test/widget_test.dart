import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:candidate_test/main.dart';

void main() {
  testWidgets('shows the default service history screen', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Детали'), findsOneWidget);
    expect(find.text('История обслуживаний'), findsOneWidget);
    expect(find.text('Vakuum Center'), findsOneWidget);
    expect(find.text('Propan Quvvat'), findsOneWidget);
  });

  testWidgets('expands and collapses a service card', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await tester.tap(find.text('Кузов'));
    await tester.pumpAndSettle();

    expect(find.text('– Локальная покраска'), findsOneWidget);

    await tester.tap(find.text('Кузов'));
    await tester.pumpAndSettle();

    expect(find.text('– Локальная покраска'), findsNothing);
  });

  testWidgets('applies filters and shows matching results', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await _openFilters(tester);
    await _tapVisibleByKey(tester, const ValueKey('filter_category_АЗС'));
    await _tapVisibleByKey(tester, const ValueKey('filter_status_completed'));
    await _tapVisibleByKey(tester, const ValueKey('filter_period_last7'));
    await _applyFilters(tester);

    expect(find.text('FathOil'), findsOneWidget);
    expect(find.text('318 000'), findsOneWidget);
    expect(
      find.textContaining('Найдено: 3', findRichText: true),
      findsOneWidget,
    );
  });

  testWidgets('applies filters and shows empty state', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await _openFilters(tester);
    await _tapVisibleByKey(tester, const ValueKey('filter_category_АЗС'));
    await _tapVisibleByKey(tester, const ValueKey('filter_status_in_progress'));
    await _tapVisibleByKey(tester, const ValueKey('filter_period_last7'));
    await _applyFilters(tester);

    expect(
      find.textContaining('Найдено: 0', findRichText: true),
      findsOneWidget,
    );
    expect(find.text('Нет результата'), findsOneWidget);
    expect(
      find.text('Попробуйте использовать другое ключевое слово'),
      findsOneWidget,
    );
  });
}

Future<void> _openFilters(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.tune).first);
  await tester.pumpAndSettle();
  expect(find.text('Фильтры'), findsOneWidget);
}

Future<void> _applyFilters(WidgetTester tester) async {
  await tester.ensureVisible(find.text('Применить'));
  await tester.tap(find.text('Применить'));
  await tester.pumpAndSettle();
}

Future<void> _tapVisibleByKey(WidgetTester tester, Key key) async {
  final finder = find.byKey(key);
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}
