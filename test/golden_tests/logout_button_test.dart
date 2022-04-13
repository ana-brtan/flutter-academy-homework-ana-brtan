import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:tv_shows/views/user_profile_screen/user_profile_screen.dart';

void main() {
  testGoldens('LogoutButton', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: LogoutButton()),
    ));

    await expectLater(find.byType(LogoutButton), matchesGoldenFile("logout_button.png"));
  });
}
