import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tv_shows/gen/assets.gen.dart';

class LoginHeader extends StatefulWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  State<LoginHeader> createState() => _LoginHeaderState();
}

class _LoginHeaderState extends State<LoginHeader> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _animationController.forward().whenComplete(() => _animationController.repeat(reverse: true));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      child: Stack(textDirection: TextDirection.rtl, fit: StackFit.expand, alignment: Alignment.centerLeft, children: [
        Positioned(left: 0, top: 0, child: Assets.images.topLeft.svg(height: 75)),
        Positioned(right: 0, top: 0, child: Assets.images.topRight.svg(width: 200, height: 250)),
        Positioned(left: 45, top: 172, child: AnimatedLogo(animationController: _animationController))
      ]),
    );
  }
}

class AnimatedLogo extends StatelessWidget {
  final AnimationController animationController;

  AnimatedLogo({required this.animationController});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 0),
          end: Offset(0, 0.3),
        ).animate(animationController),
        child: Positioned(child: Assets.images.logo.svg(fit: BoxFit.scaleDown)));
  }
}
