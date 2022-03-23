// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tv_shows/gen/assets.gen.dart';
import 'package:tv_shows/views/show%20screen/show_screen.dart';

class WelcomeScreen extends StatefulWidget {
  final String email;
  const WelcomeScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShowsScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.images.welcomeIcon.svg(),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
          Text(
            'Welcome, ' + widget.email + '!',
            style: TextStyle(
                fontSize: 17, fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: const Color(0xff808080)),
          )
        ],
      ),
    ));
  }
}
