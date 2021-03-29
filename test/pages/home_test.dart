import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:setupapp/pages/home.dart';

void main() {
  testWidgets('home should render correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Home()));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Home'), findsOneWidget);
    expect(find.byType(RaisedButton), findsOneWidget);
    expect(find.text('Log out'), findsOneWidget);
  });
}
