import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/user.dart';
import 'package:tv_shows/net/requests/sign_in_info.dart';
import 'package:tv_shows/net/storage_repository.dart';
import 'package:tv_shows/providers/login_provider.dart';
import 'package:tv_shows/views/login_screen/base_login_screen.dart';
import 'package:tv_shows/views/login_screen/register_screen.dart';

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
  final String title = 'Login';
  final String description = 'In order to continue please log in.';
  final String showOtherButtonTitle = 'Create account';

  const _Screen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _changeAuthScreen() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
    }

    _navigateToWelcomeScreen(User user) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen(email: user.email)));
    }

    Future.wait([StorageRepository.getUser(), StorageRepository.getAuthInfo()]).then((value) => {
          if (value[0] != null && value[1] != null) {_navigateToWelcomeScreen(value[0] as User)}
        });

    return ConsumerListener<LoginProvider>(
      listener: (context, provider) {
        provider.state.whenOrNull(
          success: (user) => _navigateToWelcomeScreen(user),
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
            isLoginMode: true,
            isLoading: false,
            buttonPressed: (email, password) {
              provider.login(SignInInfo(email, password));
            },
            showOtherButtonPressed: _changeAuthScreen,
            description: description,
            title: title,
            showOtherButtonTitle: showOtherButtonTitle,
          ),
          loading: () => BaseLoginScreen(
            isLoading: true,
            isLoginMode: true,
            buttonPressed: (email, password) {
              provider.login(SignInInfo(email, password));
            },
            showOtherButtonPressed: _changeAuthScreen,
            description: description,
            title: title,
            showOtherButtonTitle: showOtherButtonTitle,
          ),
        );
      },
    );
  }
}
