import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
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
      create: (context) => UserProfileProvider(context.read(), context.read()),
      child: _UserProfile(),
    );
  }
}

class _UserProfile extends StatefulWidget {
  _UserProfile();

  @override
  State<_UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<_UserProfile> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? image;
  String imagePath = "";
  String email = "";

  _onOpenGallery() async {
    image = await _imagePicker.pickImage(source: ImageSource.gallery);
  }

/*    _onSubmit() async {
      image.path
    }*/

  setEmail(String val) {
    setState(() {
      email = val;
    });
  }

  _onUpdate(UserProfileProvider provider, email) {
    provider.updateEmail(UpdateEmail(email));
    //provider.updateProfilePhoto(UpdateProfilePhoto(imagePath));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(builder: (context, provider, _) {
      return provider.state.maybeWhen(
          success: (_) => _buildSuccess(context, provider),
          loading: () => Center(child: CircularProgressIndicator()),
          failure: (e) => Center(child: Text('An error occurred')),
          orElse: () => _buildSuccess(context, provider));
    });
  }

  Widget _buildSuccess(BuildContext context, UserProfileProvider provider) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: IconButton(
                  icon: Image.asset(
                    'assets/images/profile_placeholder.png',
                  ),
                  onPressed: _onOpenGallery),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextField(
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
                  onPressed: () => _onUpdate(provider, email)),
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
