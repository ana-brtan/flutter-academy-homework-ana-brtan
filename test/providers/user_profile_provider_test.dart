import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/models/user.dart';
import 'package:tv_shows/net/network_repository.dart';
import 'package:tv_shows/net/storage_repository.dart';
import 'package:tv_shows/views/user_profile_screen/user_profile_provider.dart';

import 'user_profile_provider_test.mocks.dart';

@GenerateMocks([NetworkRepository, StorageRepository])
void main() {
  group("UserProfileProvider tests", () {
    test("UserProfileProvider", () async {
      final MockStorageRepository storageRepository = MockStorageRepository();
      final MockNetworkRepository networkRepository = MockNetworkRepository();
      UserProfileProvider userProfileProvider = UserProfileProvider(networkRepository);
      var user = new User("qwe", "ana.brtan25@gmail.com", "asdfg");

      when(networkRepository.updateProfilePhoto("asdfg")).thenAnswer((_) async => user);

      userProfileProvider.updateProfilePhoto("asdfg");

      verify(networkRepository.updateProfilePhoto("asdfg")).called(1);
    });
  });
}
