import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/common/request_state.dart';
import 'package:tv_shows/models/review.dart';
import 'package:tv_shows/models/review_provider.dart';
import 'package:tv_shows/models/user.dart';
import 'package:tv_shows/models/write_review_provider.dart';
import 'package:tv_shows/net/network_repository.dart';
import 'package:tv_shows/net/requests/add_review.dart';

import 'write_review_provider_test.mocks.dart';

@GenerateMocks([NetworkRepository, ReviewProvider])
void main() {
  group("WriteReviewsProvider tests", () {
    test('WriteReviewProvider calls fetchReviews', () async {
      final MockNetworkRepository networkRepository = MockNetworkRepository();
      final MockReviewProvider reviewProvider = MockReviewProvider();
      final writeReviewProvider = WriteReviewProvider(reviewProvider, networkRepository);

      var testAddReview = new AddReview("test comment", 2, "123");
      var testReview = new Review("123", "test comment", 2, new User("id", "email", "imageUrl"), 123);

      when(networkRepository.addShowReview(testAddReview)).thenAnswer((_) async => testReview);

      writeReviewProvider.addReview(testAddReview);

      await Future.delayed(Duration(seconds: 1));

      verify(reviewProvider.fetchReviews()).called(1);
    });
  });

  test("WriteReviewsProvider calls addShowReview", () async {
    final MockNetworkRepository networkRepository = MockNetworkRepository();
    final MockReviewProvider reviewProvider = MockReviewProvider();
    final writeReviewProvider = WriteReviewProvider(reviewProvider, networkRepository);

    var testAddReview = new AddReview("test comment", 2, "123");
    var testReview = new Review("123", "test comment", 2, new User("id", "email", "imageUrl"), 123);

    when(networkRepository.addShowReview(testAddReview)).thenAnswer((_) async => testReview);

    writeReviewProvider.addReview(testAddReview);

    verify(networkRepository.addShowReview(testAddReview)).called(1);
  });

  test("WriteReviewProvider success and loading state", () async {
    final MockNetworkRepository networkRepository = MockNetworkRepository();
    final MockReviewProvider reviewProvider = MockReviewProvider();
    final writeReviewProvider = WriteReviewProvider(reviewProvider, networkRepository);

    var testAddReview = new AddReview("test comment", 2, "123");
    var testReview = new Review("123", "test comment", 2, new User("id", "email", "imageUrl"), 123);

    when(networkRepository.addShowReview(testAddReview)).thenAnswer((_) async => testReview);

    writeReviewProvider.addReview(testAddReview);

    expect(writeReviewProvider.state is RequestStateLoading, true);
    await Future.delayed(Duration(seconds: 1));
    expect(writeReviewProvider.state is RequestStateSuccess, true);
  });
}
