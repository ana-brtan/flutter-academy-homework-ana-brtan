import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/user.dart';
import 'package:tv_shows/net/requests/update_email.dart';
import 'package:tv_shows/views/user_profile_screen/user_profile_provider.dart';

import '../../net/storage_repository.dart';
import '../login_screen/login_screen.dart';

class UserProfileScreen extends StatelessWidget {
  BuildContext parentContext;

  UserProfileScreen({Key? key, required this.parentContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProfileProvider(context.read()),
      child: _UserProfile(),
    );
  }
}

class _UserProfile extends StatefulWidget {
  _UserProfile();

  @override
  State<_UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<_UserProfile> with TickerProviderStateMixin {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? image;
  String imagePath = "";
  String email = "";
  bool imageEdited = false;
  bool emailEdited = false;
  bool isBeingUpdated = false;
  late AnimationController rotateAnimationController;
  late AnimationController scaleAnimationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    rotateAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    scaleAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    // scaleAnimationController.
    // scaleAnimationController.forward();
    // rotateAnimationController.forward();
    animation = CurvedAnimation(parent: scaleAnimationController, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    rotateAnimationController.dispose();
    scaleAnimationController.dispose();
  }

  _onOpenGallery() async {
    var xImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    this.imageEdited = xImage?.path != null;

    if (imageEdited) {
      setState(() {
        image = xImage;
      });
      rotateAnimationController.forward();
    }
  }

  _submitFunc(UserProfileProvider provider) {
    if (!imageEdited && !emailEdited) {
      return null;
    }
    return () {
      if (image?.path != null) {
        provider.updateProfilePhoto(image!.path);
        setState(() {
          isBeingUpdated = true;
        });

        Future.delayed(Duration(seconds: 1), () => scaleAnimationController.forward());
      }

      if (emailEdited) {
        provider.updateEmail(UpdateEmail(email));
      }
    };
  }

  setEmail(String val) {
    setState(() {
      email = val;
      this.emailEdited = true;
    });
  }

  Image _userImage(String? remoteURL) {
    if (image?.path != null) {
      return Image.file(new File(image!.path));
    }

    if (remoteURL != null) {
      return Image.network(remoteURL);
    }

    return Image.asset(
      'assets/images/profile_placeholder.png',
    );
  }

  _animatedProfilePhoto(User user) {
    var baseWidget = IconButton(
        iconSize: 95,
        icon: StorageRepository.user?.imageUrl != null
            ? _userImage(user.imageUrl)
            : Image.asset(('assets/images/profile_placeholder.png')),
        onPressed: _onOpenGallery);

    if (!isBeingUpdated) {
      return RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(rotateAnimationController), child: baseWidget);
    } else {
      return ScaleTransition(
        scale: animation,
        child: baseWidget,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(builder: (context, provider, _) {
      return provider.state.maybeWhen(
          success: (user) {
            return _buildSuccess(context, provider, user!);
          },
          loading: () => Center(child: Lottie.asset('assets/images/loading_simple.json')),
          failure: (e) => Center(child: Text('An error occurred')),
          orElse: () => Text("User not found"));
    });
  }

  Widget _buildSuccess(BuildContext context, UserProfileProvider provider, User user) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: CircleAvatar(
                  minRadius: 60,
                  maxRadius: 60,
                  backgroundColor: Colors.transparent,
                  child: _animatedProfilePhoto(user)),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextFormField(
                  initialValue: user.email,
                  onChanged: setEmail,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(width: 2, color: const Color(0xff3d1d72))),
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide(width: 2, color: const Color(0xff3d1d72))),
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: const Color(0xff3d1d72)))),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.5), side: BorderSide(color: const Color(0xff3d1d72))),
                  minWidth: double.infinity,
                  height: 45,
                  child: Text('Update'),
                  onPressed: () async {
                    await _submitFunc(provider);
                    await Future.delayed(Duration(milliseconds: 500));
                    Navigator.pop(context);
                  }),
            ),
            MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.5)),
                height: 45,
                minWidth: double.infinity,
                color: const Color(0xff3d1d72),
                child: Text(
                  'Logout',
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 17, color: Colors.white),
                ),
                onPressed: () async {
                  await StorageRepository.flushAuthInfo();
                  await StorageRepository.flushUser();
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
                })
          ],
          // children: [Image.asset('assets/images/ n')],
        ),
      ),
    );
  }
}
