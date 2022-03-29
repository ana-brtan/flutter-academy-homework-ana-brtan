import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/views/show_details_screen/show_details_screen.dart';

import '../../../models/shows_provider.dart';

class ShowsList extends StatelessWidget {
  const ShowsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShowsProvider>(builder: (context, data, index) {
      return ListView.builder(
          itemCount: data.shows.length,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => ShowDetailsScreen(show: data.shows[index])));
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    shadowColor: Colors.black,
                    child: Container(
                        constraints: BoxConstraints(maxHeight: 302, maxWidth: 344),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (data.shows[index].imageUrl != null)
                                ? Image.network(data.shows[index].imageUrl!, height: 193, width: 344, fit: BoxFit.cover)
                                : Container(height: 193, width: 344),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                data.shows[index].title,
                                style: TextStyle(fontFamily: 'Roboto', fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Text(
                                data.shows[index].description,
                                style:
                                    TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black.withOpacity(0.6)),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ));
    });
  }
}
