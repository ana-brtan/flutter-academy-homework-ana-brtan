import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/net/requests/sign_in_info.dart';
import 'package:tv_shows/providers/login_provider.dart';
import 'package:tv_shows/views/login_screen/base_login_screen.dart';

import '../../common/consumer_listener.dart';
import '../welcome_screen/welcome_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(context.read()),
      child: _Screen(),
    );
  }
}

class _Screen extends StatelessWidget {
  const _Screen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConsumerListener<LoginProvider>(
      listener: (context, provider) {
        provider.state.whenOrNull(
          success: (user) => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => WelcomeScreen(email: user.email))),
          failure: (_) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text('Error happend'),
            ),
          ),
        );
      },
      builder: (context, provider) {
        return provider.state.maybeWhen(
          orElse: () => BaseLoginScreen(
            isLoading: false,
            buttonPressed: (email, password) {
              provider.login(SignInInfo(email, password));
            },
          ),
          loading: () => BaseLoginScreen(
            isLoading: true,
            buttonPressed: (email, password) {
              provider.login(SignInInfo(email, password));
            },
          ),
        );
      },
    );
  }
}
