import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/net/storage_repository.dart';
import 'package:tv_shows/views/login_screen/login_screen.dart';

import 'net/network_repository.dart';

class TVShowsApp extends StatelessWidget {
  const TVShowsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => StorageRepository()),
        Provider(create: (context) => NetworkRepository(context.read<StorageRepository>())),
      ],
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}
