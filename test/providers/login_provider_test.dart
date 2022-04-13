import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/common/request_state.dart';
import 'package:tv_shows/models/user.dart';
import 'package:tv_shows/net/network_repository.dart';
import 'package:tv_shows/net/requests/sign_in_info.dart';
import 'package:tv_shows/providers/login_provider.dart';

import 'login_provider_test.mocks.dart';

@GenerateMocks([NetworkRepository])
void main() {
  group("Login Provider tests", () {
    test('Login Provider works correctly', () async {
      final MockNetworkRepository networkRepository = MockNetworkRepository();
      final loginProvider = LoginProvider(networkRepository);

      var testSignInInfo = new SignInInfo("ana.brtan25@gmail.com", "test123");
      var user = new User("qwe", "ana.brtan25@gmail.com", "asdfg");

      when(networkRepository.signInUser(testSignInInfo)).thenAnswer((_) async => user);
      loginProvider.login(testSignInInfo);

      verify(networkRepository.signInUser(testSignInInfo)).called(1);
    });

    test("LoginProvider loading and success states", () async {
      final MockNetworkRepository networkRepository = MockNetworkRepository();
      final loginProvider = LoginProvider(networkRepository);

      var testSignInInfo = new SignInInfo("ana.brtan25@gmail.com", "test123");
      var user = new User("qwe", "ana.brtan25@gmail.com", "asdfg");

      when(networkRepository.signInUser(testSignInInfo)).thenAnswer((_) async => user);
      loginProvider.login(testSignInInfo);

      expect(loginProvider.state is RequestStateLoading, true);
      await Future.delayed(Duration(seconds: 1));
      expect(loginProvider.state is RequestStateSuccess, true);
    });
  });
}
