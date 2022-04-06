import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/show.dart';

import '../../../models/review_provider.dart';

class Reviews extends StatelessWidget {
  Show show;

  Reviews({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewProvider>(builder: (context, data, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text(
              "Reviews",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          Visibility(
            visible: data.reviews.length > 0,
            replacement: Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Row(
                children: [Text("No reviews yet.", style: TextStyle(fontSize: 17))],
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      "${show.numOfReviews} REVIEWS, ${show.averageRating} AVERAGE",
                      style: TextStyle(color: Color(0xff999999), fontSize: 14),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: RatingBar(
                    initialRating: show.averageRating,
                    itemCount: 5,
                    allowHalfRating: true,
                    ratingWidget: RatingWidget(
                        full: Icon(
                          Icons.star,
                          color: Color(0xff52368C),
                        ),
                        half: Icon(Icons.star_half, color: Color(0xff52368C)),
                        empty: Icon(Icons.star_outline, color: Color(0xff52368C))),
                    onRatingUpdate: (double value) {},
                  ),
                ),
                _reviewList()
              ],
            ),
          )
        ],
      );
    });
  }

  _reviewList() {
    return Consumer<ReviewProvider>(
        builder: (context, data, index) => Column(
              children: [
                ...data.reviews.asMap().entries.map(
                  (element) {
                    var index = element.key;
                    var review = element.value;

                    return Container(
                      decoration: index > 0
                          ? BoxDecoration(
                              border: Border(
                              top: BorderSide(width: 0.5, color: Color(0xffC8C7CC)),
                            ))
                          : null,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      review.user.imageUrl != null
                                          ? Image.network(
                                              review.user.imageUrl!,
                                              height: 75,
                                              width: 75,
                                            )
                                          : Container(height: 75, width: 75),
                                      SizedBox(width: 18),
                                      Text(review.user.email,
                                          style: TextStyle(
                                              color: Color(0xff52368C), fontWeight: FontWeight.bold, fontSize: 13),
                                          overflow: TextOverflow.ellipsis)
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(review.rating.toString(),
                                        style: TextStyle(
                                            color: Color(0xff52368C), fontWeight: FontWeight.bold, fontSize: 15)),
                                    review.rating != null
                                        ? Icon(
                                            Icons.star,
                                            color: Color(0xff52368C),
                                          )
                                        : Container(
                                            width: 100,
                                            height: 100,
                                          )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 18),
                            Row(children: [Text(review.comment, style: TextStyle(fontSize: 15))])
                          ],
                        ),
                      ),
                    );
                  },
                ).toList()
              ],
            ));
  }
}
