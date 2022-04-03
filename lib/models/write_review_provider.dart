import 'package:tv_shows/models/review.dart';
import 'package:tv_shows/models/review_provider.dart';
import 'package:tv_shows/net/network_repository.dart';
import 'package:tv_shows/net/requests/add_review.dart';

import '../common/request_provider.dart';

class WriteReviewProvider extends RequestProvider<Review> {
  ReviewProvider reviewProvider;
  NetworkRepository _networkRepository;

  Future addReview(AddReview body) {
    return executeRequest(requestBuilder: () => _networkRepository.addShowReview(body))
        .then((value) => reviewProvider.fetchReviews());
  }

  WriteReviewProvider(this.reviewProvider, this._networkRepository);
}
