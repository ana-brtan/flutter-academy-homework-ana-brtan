import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_shows/views/login_screen/components/login_form.dart';

void main() {
  group("login form test", () {
    testWidgets("validate form disabled", (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
                body: LoginForm(
                    showOtherButtonTitle: 'button2',
                    showOtherButtonPressed: () {},
                    buttonPressed: (_, b_) {},
                    buttonTitle: 'button1',
                    isLoading: false,
                    description: 'description',
                    title: 'title')),
          ),
        );

        expect(tester.widget<MaterialButton>(find.byKey(Key('submitButton'))).onPressed, isNull);
      });
    });

    testWidgets("validate form enabled", (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
                body: LoginForm(
                    showOtherButtonTitle: 'button2',
                    showOtherButtonPressed: () {},
                    buttonPressed: (_, b_) {},
                    buttonTitle: 'button1',
                    isLoading: false,
                    description: 'description',
                    title: 'title')),
          ),
        );

        await tester.enterText(find.byKey(Key('emailInput')), "ana.brtan25@gmail.com");
        await tester.enterText(find.byKey(Key('passwordInput')), "test123");

        await tester.pump(Duration());

        expect(tester.widget<MaterialButton>(find.byKey(Key('submitButton'))).onPressed, isNotNull);
      });
    });

    testWidgets("button press", (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
                body: LoginForm(
                    showOtherButtonTitle: 'button2',
                    showOtherButtonPressed: () {},
                    buttonPressed: (_, b_) {},
                    buttonTitle: 'button1',
                    isLoading: false,
                    description: 'description',
                    title: 'title')),
          ),
        );

        var emailField = find.byKey(Key('emailInput'));
        await tester.tap(emailField);
        await tester.enterText(emailField, "email");
        await find.text("email");
      });
    });

    testWidgets("button press", (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
                body: LoginForm(
                    showOtherButtonTitle: 'button2',
                    showOtherButtonPressed: () {},
                    buttonPressed: (_, b_) {},
                    buttonTitle: 'button1',
                    isLoading: false,
                    description: 'description',
                    title: 'title')),
          ),
        );

        var passwordField = find.byKey(Key('passwordInput'));
        await tester.tap(passwordField);
        await tester.enterText(passwordField, "password");
        await find.text("password");
      });
    });
    testWidgets("Login title and button show", (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
                body: LoginForm(
                    showOtherButtonTitle: 'button2',
                    showOtherButtonPressed: () {},
                    buttonPressed: (_, b_) {},
                    buttonTitle: 'Login',
                    isLoading: false,
                    description: 'description',
                    title: 'Login')),
          ),
        );

        expect(find.text("Login"), findsNWidgets(2));
        expect(find.text("Register"), findsNothing);
      });
    });
  });
}
