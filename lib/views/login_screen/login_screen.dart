import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/net/network_repository.dart';
import 'package:tv_shows/net/requests/sign_in_info.dart';
import 'package:tv_shows/views/login_screen/components/login_form.dart';
import 'package:tv_shows/views/welcome_screen/welcome_screen.dart';

import '../../net/requests/register_info.dart';
import 'components/login_header.dart';

class BaseLoginScreen extends StatelessWidget {
  bool isLoginMode = true;

  BaseLoginScreen({Key? key, required this.isLoginMode}) : super(key: key);

  String get _description {
    return isLoginMode ? "In order to continue please log in." : "In order to continue please register";
  }

  String get _title {
    return isLoginMode ? "Login" : "Register";
  }

  String get _otherButtonTitle {
    return isLoginMode ? "Create account" : "Sign in";
  }

  @override
  Widget build(BuildContext context) {
    _changeAuthScreen() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BaseLoginScreen(isLoginMode: !isLoginMode)));
    }

    void _process_auth(email, password) {
      var api = Provider.of<NetworkRepository>(context, listen: false);

      if (isLoginMode) {
        // login

        api.signInUser(SignInInfo(email, password)).then((user) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen(email: email)));
        });

        return;
      }

      api.registerUser(RegisterInfo(email, password, password)).then((user) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen(email: email)));
      }).onError((error, stackTrace) => null);
      // register
    }

    return Scaffold(
      backgroundColor: const Color(0xff3d1d72),
      body: SingleChildScrollView(
        child: Column(children: [
          LoginHeader(),
          Container(height: 10),
          Center(
            child: LoginForm(
              title: _title,
              description: _description,
              showOtherButtonPressed: _changeAuthScreen,
              showOtherButtonTitle: _otherButtonTitle,
              buttonTitle: _title,
              buttonPressed: _process_auth,
            ),
          ),
        ]),
      ),
    );
  }
}
