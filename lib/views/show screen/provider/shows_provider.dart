import 'package:tv_shows/models/show.dart';
import 'package:tv_shows/models/user.dart';
import 'package:tv_shows/net/network_repository.dart';
import 'package:tv_shows/net/requests/sign_in_info.dart';

import '../../../common/request_provider.dart';

class ShowsProvider extends RequestProvider<List<Show>> {
  final NetworkRepository _networkRepository;

  ShowsProvider(this._networkRepository) {
    fetchShows();
  }

  void fetchShows() {
    executeRequest(requestBuilder: () => _networkRepository.fetchShows());
  }
}
