import 'package:flutter/material.dart';

import 'views/login_screen/login_screen.dart';

class TVShowsApp extends StatelessWidget {
  const TVShowsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginScreen());
  }
}
