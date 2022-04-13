import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/common/request_state.dart';
import 'package:tv_shows/models/user.dart';
import 'package:tv_shows/net/network_repository.dart';
import 'package:tv_shows/net/requests/register_info.dart';
import 'package:tv_shows/net/requests/sign_in_info.dart';
import 'package:tv_shows/providers/register_provider.dart';

import 'login_provider_test.mocks.dart';

@GenerateMocks([NetworkRepository])
void main() {
  group("Register Provider tests", () {
    test("RegisterProvider calls registerUser", () {
      final MockNetworkRepository networkRepository = MockNetworkRepository();
      final registerProvider = RegisterProvider(networkRepository);

      var testRegisterInfo = new RegisterInfo("ana.brtan25@gmail.com", "test123", "test123");
      var user = new User("qwe", "ana.brtan25@gmail.com", "asdfg");

      when(networkRepository.registerUser(testRegisterInfo)).thenAnswer((_) async => user);
      registerProvider.registerUser(testRegisterInfo);

      verify(networkRepository.registerUser(testRegisterInfo)).called(1);
    });
  });
  test("RegisterProvider never calls signInUser", () {
    final MockNetworkRepository networkRepository = MockNetworkRepository();
    final registerProvider = RegisterProvider(networkRepository);

    var testRegisterInfo = new RegisterInfo("ana.brtan25@gmail.com", "test123", "test123");
    var testSignInInfo = new SignInInfo("ana.brtan25@gmail.com", "test123");
    var user = new User("qwe", "ana.brtan25@gmail.com", "asdfg");

    when(networkRepository.registerUser(testRegisterInfo)).thenAnswer((_) async => user);
    registerProvider.registerUser(testRegisterInfo);

    verifyNever(networkRepository.signInUser.call(testSignInInfo));
  });

  test("RegisterProvider loading and success state", () async {
    final MockNetworkRepository networkRepository = MockNetworkRepository();
    final registerProvider = RegisterProvider(networkRepository);

    var testRegisterInfo = new RegisterInfo("ana.brtan25@gmail.com", "test123", "test123");
    var user = new User("qwe", "ana.brtan25@gmail.com", "asdfg");

    when(networkRepository.registerUser(testRegisterInfo)).thenAnswer((_) async => user);
    registerProvider.registerUser(testRegisterInfo);

    expect(registerProvider.state is RequestStateLoading, true);
    await Future.delayed(Duration(seconds: 1));
    expect(registerProvider.state is RequestStateSuccess, true);
  });
}
