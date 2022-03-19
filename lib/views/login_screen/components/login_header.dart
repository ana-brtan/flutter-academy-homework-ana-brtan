import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tv_shows/gen/assets.gen.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      child: Stack(textDirection: TextDirection.rtl, fit: StackFit.expand, alignment: Alignment.centerLeft, children: [
        Positioned(left: 0, top: 0, child: Assets.images.topLeft.svg(height: 75)),
        Positioned(right: 0, top: 0, child: Assets.images.topRight.svg(width: 200, height: 250)),
        Positioned(left: 45, top: 172, child: Assets.images.logo.svg(width: 35, height: 35))
      ]),
    );
  }
}
