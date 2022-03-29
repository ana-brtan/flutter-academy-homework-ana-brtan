import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/write_review_provider.dart';

import '../../models/review_provider.dart';
import '../../net/network_repository.dart';

class WriteReviews extends StatefulWidget {
  String showId = '';
  ReviewProvider reviewProvider;

  WriteReviews(this.showId, this.reviewProvider, {Key? key}) : super(key: key);

  @override
  State<WriteReviews> createState() => _WriteReviewsState();
}

class _WriteReviewsState extends State<WriteReviews> {
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
    var api = Provider.of<NetworkRepository>(context);

    var writeReviewProvider = WriteReviewProvider(widget.reviewProvider, api);
    onReviewSubmit() {
      writeReviewProvider.submitReview(comment, rating, widget.showId);
    }

    return Container(
      child: Padding(
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
                onPressed: onReviewSubmit),
          )
        ]),
      ),
    );
  }
}
