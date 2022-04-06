import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/review_provider.dart';
import 'package:tv_shows/models/write_review_provider.dart';
import 'package:tv_shows/net/requests/add_review.dart';

import '../../models/show.dart';

class WriteReviewsScreen extends StatelessWidget {
  Show show;
  BuildContext parentContext;

  WriteReviewsScreen({Key? key, required this.show, required this.parentContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WriteReviewProvider(Provider.of<ReviewProvider>(parentContext), context.read()),
      child: _WriteReviews(show.id),
    );
  }
}

class _WriteReviews extends StatefulWidget {
  String showId = '';

  _WriteReviews(this.showId);

  @override
  State<_WriteReviews> createState() => _WriteReviewsState();
}

class _WriteReviewsState extends State<_WriteReviews> {
  String comment = "";

  int rating = 0;

  _setComment(String value) {
    setState(() {
      comment = value;
    });
  }

  _setRating(int value) {
    setState(() {
      rating = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WriteReviewProvider>(builder: (context, provider, _) {
      return provider.state.maybeWhen(
          success: (_) => _buildSuccess(context, provider),
          loading: () => Center(child: CircularProgressIndicator()),
          failure: (e) => Center(child: Text('An error occured')),
          orElse: () => _buildSuccess(context, provider));
    });
  }

  Widget _buildSuccess(BuildContext context, WriteReviewProvider provider) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Write a review',
                style: TextStyle(fontFamily: 'Roboto', fontSize: 24, fontWeight: FontWeight.bold),
              ),
              CloseButton(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: RatingBar(
              itemCount: 5,
              allowHalfRating: false,
              ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Color(0xff52368C),
                  ),
                  half: const Icon(Icons.star_half, color: Color(0xff52368C)),
                  empty: const Icon(Icons.star_outline, color: Color(0xff52368C))),
              onRatingUpdate: (double value) {
                _setRating(value.toInt());
              },
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextField(
                  onChanged: _setComment,
                  maxLines: null,
                  decoration: const InputDecoration(
                      labelText: 'Comment',
                      labelStyle: TextStyle(color: Color(0xff52368C)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff52368C))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff52368C)))),
                  autofocus: true)),
          Padding(
            padding: const EdgeInsets.only(top: 36),
            child: MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.5)),
              color: const Color(0xff52368C),
              minWidth: double.infinity,
              child: const Text(
                "Submit",
                style: TextStyle(fontFamily: 'Roboto', fontSize: 17, color: Colors.white),
              ),
              onPressed: () =>
                  provider.addReview(AddReview(comment, rating, widget.showId)).then((value) => Navigator.pop(context)),
            ),
          )
        ]));
  }
}
