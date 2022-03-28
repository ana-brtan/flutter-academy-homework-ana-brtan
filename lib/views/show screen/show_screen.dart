import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/gen/assets.gen.dart';
import 'package:tv_shows/net/network_repository.dart';

import '../../models/shows_provider.dart';
import 'components/shows_list.dart';

class ShowsScreen extends StatefulWidget {
  ShowsScreen({Key? key}) : super(key: key);

  @override
  State<ShowsScreen> createState() => _ShowsScreenState();
}

class _ShowsScreenState extends State<ShowsScreen> {
  bool listVisible = true;
  NetworkRepository api = NetworkRepository();

  @override
  Widget build(BuildContext context) {
    var showsProvider = ShowsProvider();
    // showsProvider.addMany(Show.allShows);

    var api = Provider.of<NetworkRepository>(context, listen: false);
    api.fetchShows().then((shows) => showsProvider.addMany(shows));

    _header() {
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

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
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
                      child: ChangeNotifierProvider(create: (context) => showsProvider, child: const ShowsList()))),
//              TextButton(onPressed: () => showsProvider.clear(), child: const Text("Press me"))
            ],
          )),
        ));
  }
}
