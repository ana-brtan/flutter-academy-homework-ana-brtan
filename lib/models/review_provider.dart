import 'package:tv_shows/models/review.dart';

import '../common/request_provider.dart';
import '../net/network_repository.dart';

class ReviewProvider extends RequestProvider<List<Review>> {
  final NetworkRepository _networkRepository;
  String showID;

  ReviewProvider(this._networkRepository, this.showID) {
    fetchReviews();
  }

  void fetchReviews() {
    executeRequest(requestBuilder: () => _networkRepository.fetchShowReviews(showID));
  }
}
