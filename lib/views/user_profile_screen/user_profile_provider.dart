import 'package:tv_shows/models/user.dart';
import 'package:tv_shows/net/network_repository.dart';
import 'package:tv_shows/net/requests/update_email.dart';
import 'package:tv_shows/net/storage_repository.dart';

import '../../common/request_provider.dart';

class UserProfileProvider extends RequestProvider<User?> {
  final NetworkRepository _networkRepository;

  UserProfileProvider(this._networkRepository) {
    getUser();
  }

  void updateProfilePhoto(String imagePath) {
    executeRequest(requestBuilder: () => _networkRepository.updateProfilePhoto(imagePath));
  }

  void updateEmail(UpdateEmail body) {
    executeRequest(requestBuilder: () => _networkRepository.updateEmail(body));
  }

  void getUser() {
    executeRequest(requestBuilder: () => StorageRepository.getUser());
  }
}
