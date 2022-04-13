import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/models/show.dart';
import 'package:tv_shows/net/network_repository.dart';
import 'package:tv_shows/views/show%20screen/provider/shows_provider.dart';

import 'login_provider_test.mocks.dart';

@GenerateMocks([NetworkRepository])
void main() {
  group("ShowProvider tests", () {
    test("ShowProvider", () {
      final MockNetworkRepository networkRepository = MockNetworkRepository();
      final ShowsProvider showsProvider = ShowsProvider(networkRepository);
      List<Show> shows = [];

      verify(showsProvider.fetchShows()).called(1);
    });

    test("ShowProvider calls fetchShows", () {
      final MockNetworkRepository networkRepository = MockNetworkRepository();
      List<Show> shows = [];

      when(networkRepository.fetchShows()).thenAnswer((_) async => shows);
      verify(networkRepository.fetchShows()).called(1);
    });
  });
}
