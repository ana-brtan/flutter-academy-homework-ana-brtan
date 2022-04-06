import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/net/auth_info_holder.dart';
import 'package:tv_shows/views/login_screen/login_screen.dart';

import 'net/network_repository.dart';
import 'views/login_screen/base_login_screen.dart';

class TVShowsApp extends StatelessWidget {
  const TVShowsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthInfoHolder()),
        Provider(create: (context) => NetworkRepository(context.read<AuthInfoHolder>())),
      ],
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}
