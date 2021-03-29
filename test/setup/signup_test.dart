import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:setupapp/setup/signup.dart';

void main() {
  testWidgets('Testing the sign up', (WidgetTester tester) async {
   await tester.pumpWidget(MaterialApp(home: Signup()));
  });
}