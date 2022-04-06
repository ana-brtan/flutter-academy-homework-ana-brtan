import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/net/requests/register_info.dart';
import 'package:tv_shows/views/login_screen/base_login_screen.dart';
import 'package:tv_shows/views/login_screen/login_screen.dart';

import '../../common/consumer_listener.dart';
import '../../providers/register_provider.dart';
import '../welcome_screen/welcome_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(context.read()),
      child: _Screen(),
    );
  }
}

class _Screen extends StatelessWidget {
  final String title = 'Register';
  final String description = 'In order to continue please register.';
  final String showOtherButtonTitle = 'Login';

  const _Screen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _changeAuthScreen() {
      print('register, change auth');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    }

    return ConsumerListener<RegisterProvider>(
      listener: (context, provider) {
        provider.state.whenOrNull(
          success: (user) => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => WelcomeScreen(email: user.email))),
          failure: (_) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text('An error occured'),
            ),
          ),
        );
      },
      builder: (context, provider) {
        return provider.state.maybeWhen(
          orElse: () => BaseLoginScreen(
            title: title,
            description: description,
            showOtherButtonPressed: _changeAuthScreen,
            isLoginMode: false,
            isLoading: false,
            buttonPressed: (email, password) {
              provider.registerUser(RegisterInfo(email, password, password));
            },
            showOtherButtonTitle: showOtherButtonTitle,
          ),
          loading: () => BaseLoginScreen(
            title: title,
            description: description,
            showOtherButtonPressed: _changeAuthScreen,
            isLoginMode: false,
            isLoading: true,
            buttonPressed: (email, password) {
              provider.registerUser(RegisterInfo(email, password, password));
            },
            showOtherButtonTitle: showOtherButtonTitle,
          ),
        );
      },
    );
  }
}
