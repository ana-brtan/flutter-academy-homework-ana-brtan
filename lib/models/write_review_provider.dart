import 'package:flutter/cupertino.dart';
import 'package:tv_shows/models/review_provider.dart';
import 'package:tv_shows/net/network_repository.dart';
import 'package:tv_shows/net/requests/add_review.dart';

class WriteReviewProvider extends ChangeNotifier {
  ReviewProvider reviewProvider;
  NetworkRepository networkRepository;

  Future submitReview(String comment, int rating, String showId) async {
    return networkRepository
        .addShowReview(AddReview(comment, rating, showId))
        .then((value) => reviewProvider.addSingle(value));
  }

  WriteReviewProvider(this.reviewProvider, this.networkRepository);
}
