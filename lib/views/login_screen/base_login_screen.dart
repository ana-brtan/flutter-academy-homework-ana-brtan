import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tv_shows/views/login_screen/components/login_form.dart';

import 'components/login_header.dart';

class BaseLoginScreen extends StatelessWidget {
  bool isLoginMode = true;
  final bool isLoading;
  final Function(String email, String password) buttonPressed;
  VoidCallback showOtherButtonPressed;
  String title = "";
  String description = "";
  String showOtherButtonTitle;

  BaseLoginScreen(
      {Key? key,
      required this.title,
      required this.description,
      required this.showOtherButtonPressed,
      required this.showOtherButtonTitle,
      required this.isLoginMode,
      required this.isLoading,
      required this.buttonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3d1d72),
      body: SingleChildScrollView(
        child: Column(children: [
          LoginHeader(),
          Container(height: 10),
          Center(
            child: LoginForm(
                title: title,
                description: description,
                showOtherButtonPressed: showOtherButtonPressed,
                showOtherButtonTitle: showOtherButtonTitle,
                buttonTitle: title,
                buttonPressed: buttonPressed,
                isLoading: isLoading),
          ),
        ]),
      ),
    );
  }
}
