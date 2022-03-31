import 'package:tv_shows/models/user.dart';
import 'package:tv_shows/net/network_repository.dart';
import 'package:tv_shows/net/requests/sign_in_info.dart';

import '../common/request_provider.dart';

class LoginProvider extends RequestProvider<User> {

  final NetworkRepository _networkRepository;

  LoginProvider(this._networkRepository);


  void login(SignInInfo signInInfo) {
    executeRequest(requestBuilder: () => _networkRepository.signInUser(signInInfo));
  }
}