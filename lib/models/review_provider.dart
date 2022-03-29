import 'package:flutter/cupertino.dart';
import 'package:tv_shows/models/review.dart';

class ReviewProvider extends ChangeNotifier {
  List<Review> _reviews = [];

  List<Review> get reviews => _reviews;

  void addMany(List<Review> items) {
    _reviews = items;
    notifyListeners();
  }

  void addSingle(Review item) {
    _reviews.add(item);
    notifyListeners();
  }

  void clear() {
    _reviews.clear();
    notifyListeners();
  }
}
