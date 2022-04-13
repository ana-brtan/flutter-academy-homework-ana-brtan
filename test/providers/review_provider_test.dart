import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/models/review.dart';
import 'package:tv_shows/models/review_provider.dart';
import 'package:tv_shows/net/network_repository.dart';

import 'login_provider_test.mocks.dart';

@GenerateMocks([NetworkRepository])
void main() {
  group("ReviewProvider tests", () {
    test("ReviewProvider calls fetchReviews", () {
      final MockNetworkRepository networkRepository = MockNetworkRepository();
      String showID = "";
      final ReviewProvider reviewProvider = ReviewProvider(networkRepository, showID);
      List<Review> reviews = [];

      when(networkRepository.fetchShowReviews(showID)).thenAnswer((_) async => reviews);

      verify(reviewProvider.fetchReviews()).called(1);
    });

    test("ReviewProvider calls fetchShowReviews", () {
      final MockNetworkRepository networkRepository = MockNetworkRepository();
      String showID = "show1";
      final ReviewProvider reviewProvider = ReviewProvider(networkRepository, showID);
      List<Review> reviews = [];
      when(networkRepository.fetchShowReviews(showID)).thenAnswer((_) async => reviews);

      verify(networkRepository.fetchShowReviews(showID)).called(1);
    });
  });
}
