import 'package:flutter/cupertino.dart';
import 'package:tv_shows/models/show.dart';

class ShowsProvider extends ChangeNotifier {
  List<Show> _shows = [];

  List<Show> get shows => _shows;

  void addMany(List<Show> items) {
    _shows = items;
    notifyListeners();
  }

  void clear() {
    _shows.clear();
    notifyListeners();
  }
}
