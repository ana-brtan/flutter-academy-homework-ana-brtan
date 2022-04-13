import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginForm extends StatefulWidget {
  String? title;
  String? description;
  String showOtherButtonTitle;
  Function(String, String) buttonPressed;
  VoidCallback showOtherButtonPressed;
  String buttonTitle;
  final bool isLoading;

  @override
  State<StatefulWidget> createState() => _LoginFormState();

  LoginForm({
    Key? key,
    this.title,
    this.description,
    required this.showOtherButtonPressed,
    required this.buttonPressed,
    required this.showOtherButtonTitle,
    required this.buttonTitle,
    required this.isLoading,
  }) : super(key: key) {}
}

class _LoginFormState extends State<LoginForm> {
  bool _isHidden = false;
  String email = "";
  String password = "";
  bool iconVisible = false;
  bool isFormValid = false;

  validateForm() {
    setState(() {
      isFormValid = email.isNotEmpty && password.isNotEmpty;
    });
  }

  setEmail(val) {
    email = val;
    validateForm();
  }

  setPassword(val) {
    password = val;
    validateForm();
    iconVisible = password.isNotEmpty;
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    _text() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.title ?? "",
            style:
                const TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold)),
        Container(height: 20),
        Text(widget.description ?? "",
            style: const TextStyle(
                fontFamily: 'Roboto', color: Colors.white, fontSize: 17, fontWeight: FontWeight.normal)),
      ]);
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
        _text(),
        Container(
          margin: const EdgeInsets.only(top: 36),
          child: TextField(
            key: Key('emailInput'),
            onChanged: setEmail,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.5),
                    borderSide: const BorderSide(width: 2, color: Colors.white)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.white)),
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.white)),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 25, bottom: 0),
          child: TextField(
            key: Key('passwordInput'),
            onChanged: setPassword,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            obscureText: !_isHidden,
            decoration: InputDecoration(
                suffix: InkWell(
                    onTap: _togglePasswordView,
                    child: SvgPicture.asset(
                      _isHidden ? ('assets/images/Invisible.svg') : ('assets/images/Visible.svg'),
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.5),
                    borderSide: const BorderSide(width: 2, color: Colors.white)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.white)),
                labelText: 'Password',
                labelStyle: const TextStyle(color: Colors.white)),
          ),
        ),
        Center(
          child: TextButton(
              onPressed: widget.showOtherButtonPressed,
              child: Text(widget.showOtherButtonTitle,
                  style: const TextStyle(
                      fontFamily: 'Roboto', fontSize: 17, color: Colors.white, decoration: TextDecoration.underline))),
        ),
        Container(
          margin: const EdgeInsets.only(top: 60),
          child: widget.isLoading
              ? Center(child: CircularProgressIndicator())
              : LoginFormButton(widget: widget, isFormValid: isFormValid, email: email, password: password),
        ),
      ]),
    );
  }
}

class LoginFormButton extends StatelessWidget {
  const LoginFormButton({
    Key? key,
    required this.widget,
    required this.isFormValid,
    required this.email,
    required this.password,
  }) : super(key: key);

  final LoginForm widget;
  final bool isFormValid;
  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        key: Key('submitButton'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.5)),
        height: 45,
        minWidth: double.infinity,
        color: Colors.white,
        disabledColor: const Color(0xffbbbbbbb).withOpacity(0.5),
        child: Text(
          widget.buttonTitle,
          style: TextStyle(
              fontFamily: 'Roboto', fontSize: 17, color: isFormValid ? const Color(0xff3d1d72) : Colors.white),
        ),
        onPressed: isFormValid ? () => widget.buttonPressed(email, password) : null);
  }
}
