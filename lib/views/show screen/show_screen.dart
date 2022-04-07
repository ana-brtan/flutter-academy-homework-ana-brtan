import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/gen/assets.gen.dart';
import 'package:tv_shows/models/show.dart';
import 'package:tv_shows/views/show%20screen/provider/shows_provider.dart';
import 'package:tv_shows/views/user_profile_screen/user_profile_screen.dart';

import '../../net/storage_repository.dart';
import 'components/shows_list.dart';

class ShowsScreen extends StatelessWidget {
  const ShowsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShowsProvider(context.read()),
      child: _Screen(),
    );
  }
}

class _Screen extends StatefulWidget {
  _Screen({Key? key}) : super(key: key);

  @override
  State<_Screen> createState() => _ShowsScreenState();
}

class _ShowsScreenState extends State<_Screen> {
  bool listVisible = true;

  @override
  Widget build(BuildContext context) {
    context.watch<StorageRepository>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          CircleAvatar(
            child: IconButton(
                icon: StorageRepository.user?.imageUrl != null
                    ? ClipOval(
                        child: Image.network(StorageRepository.user!.imageUrl!),
                      )
                    : Image.asset('assets/images/profile_placeholder.png'),
                onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    shape:
                        const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
                    context: context,
                    builder: (context) {
                      return UserProfileScreen(parentContext: this.context);
                    })),
          )
        ],
      ),
      body: Consumer<ShowsProvider>(builder: (context, provider, _) {
        return provider.state.maybeWhen(
            success: (shows) => _buildSuccess(context, shows),
            loading: () => CircularProgressIndicator(),
            failure: (error) => Center(child: Text('$error')),
            orElse: () => Center(child: CircularProgressIndicator()));
      }),
    );
  }

  Widget _buildSuccess(BuildContext context, List<Show> shows) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            Visibility(
              visible: listVisible,
              replacement: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.images.emptyState.image(),
                    const Padding(
                      padding: EdgeInsets.all(26),
                      child: Text('Your shows are not showing. Get it?',
                          style: TextStyle(fontFamily: 'Roboto', fontSize: 16, color: Color(0xff808080))),
                    )
                  ],
                ),
              ),
              child: Expanded(
                child: ShowsList(shows: shows),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Shows',
              style: TextStyle(fontFamily: 'Roboto', fontSize: 36, fontWeight: FontWeight.bold),
            ),
            OutlinedButton(
                child: listVisible ? Text('Hide') : Text('Show'),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    side: const BorderSide(color: Color(0xff79747E))),
                onPressed: () {
                  setState(() {
                    listVisible = !listVisible;
                  });
                }),
          ],
        ));
  }
}
