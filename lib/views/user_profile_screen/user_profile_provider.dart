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

  void updateUserProfile(String? imagePath, UpdateEmail? body) async {
    List<Future<User>> requestQueue = [];

    if (body?.email != "") {
      requestQueue.add(_networkRepository.updateEmail(body!));
    }

    if (imagePath != null) {
      requestQueue.add(_networkRepository.updateProfilePhoto(imagePath));
    }

    try {
      var response = await Future.wait(requestQueue);
      executeRequest(requestBuilder: () => StorageRepository.getUser());
    } catch (err) {
      throw Exception('error');
    }
  }
}
