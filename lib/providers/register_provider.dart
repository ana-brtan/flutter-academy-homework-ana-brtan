import 'package:tv_shows/models/user.dart';
import 'package:tv_shows/net/network_repository.dart';

import '../common/request_provider.dart';
import '../net/requests/register_info.dart';

class RegisterProvider extends RequestProvider<User> {
  final NetworkRepository _networkRepository;

  RegisterProvider(this._networkRepository);

  void registerUser(RegisterInfo info) {
    executeRequest(requestBuilder: () => _networkRepository.registerUser(info));
  }
}
