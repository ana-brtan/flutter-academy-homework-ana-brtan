import 'package:flutter/cupertino.dart';
import 'package:tv_shows/models/review.dart';

class ReviewProvider extends ChangeNotifier {
  List<Review> _reviews = [];

  List<Review> get reviews => Review.allReviews;

  void addMany(List<Review> items) {
    _reviews = items;
    notifyListeners();
  }

  void clear() {
    _reviews.clear();
    notifyListeners();
  }
}
