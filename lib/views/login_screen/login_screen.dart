// ignore_for_file: prefer_const_constructors
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tv_shows/views/login_screen/components/login_form.dart';

import 'components/login_header.dart';

class LoginScreen extends StatelessWidget {
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
              title: "Login",
              description: "In order to continue please log in",
            ),
          ),
        ]),
      ),
    );
  }
}
