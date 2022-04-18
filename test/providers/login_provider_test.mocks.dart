// Mocks generated by Mockito 5.1.0 from annotations
// in tv_shows/test/providers/login_provider_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:tv_shows/models/review.dart' as _i3;
import 'package:tv_shows/models/show.dart' as _i8;
import 'package:tv_shows/models/user.dart' as _i2;
import 'package:tv_shows/net/network_repository.dart' as _i4;
import 'package:tv_shows/net/requests/add_review.dart' as _i9;
import 'package:tv_shows/net/requests/register_info.dart' as _i6;
import 'package:tv_shows/net/requests/sign_in_info.dart' as _i7;
import 'package:tv_shows/net/requests/update_email.dart' as _i10;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeUser_0 extends _i1.Fake implements _i2.User {}

class _FakeReview_1 extends _i1.Fake implements _i3.Review {}

/// A class which mocks [NetworkRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkRepository extends _i1.Mock implements _i4.NetworkRepository {
  MockNetworkRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.User> registerUser(_i6.RegisterInfo? info) =>
      (super.noSuchMethod(Invocation.method(#registerUser, [info]),
              returnValue: Future<_i2.User>.value(_FakeUser_0()))
          as _i5.Future<_i2.User>);
  @override
  _i5.Future<_i2.User> signInUser(_i7.SignInInfo? info) =>
      (super.noSuchMethod(Invocation.method(#signInUser, [info]),
              returnValue: Future<_i2.User>.value(_FakeUser_0()))
          as _i5.Future<_i2.User>);
  @override
  _i5.Future<List<_i8.Show>> fetchShows() =>
      (super.noSuchMethod(Invocation.method(#fetchShows, []),
              returnValue: Future<List<_i8.Show>>.value(<_i8.Show>[]))
          as _i5.Future<List<_i8.Show>>);
  @override
  _i5.Future<List<_i3.Review>> fetchShowReviews(String? showID) =>
      (super.noSuchMethod(Invocation.method(#fetchShowReviews, [showID]),
              returnValue: Future<List<_i3.Review>>.value(<_i3.Review>[]))
          as _i5.Future<List<_i3.Review>>);
  @override
  _i5.Future<_i3.Review> addShowReview(_i9.AddReview? body) =>
      (super.noSuchMethod(Invocation.method(#addShowReview, [body]),
              returnValue: Future<_i3.Review>.value(_FakeReview_1()))
          as _i5.Future<_i3.Review>);
  @override
  _i5.Future<_i2.User> updateEmail(_i10.UpdateEmail? body) =>
      (super.noSuchMethod(Invocation.method(#updateEmail, [body]),
              returnValue: Future<_i2.User>.value(_FakeUser_0()))
          as _i5.Future<_i2.User>);
  @override
  _i5.Future<_i2.User> updateProfilePhoto(String? imagePath) =>
      (super.noSuchMethod(Invocation.method(#updateProfilePhoto, [imagePath]),
              returnValue: Future<_i2.User>.value(_FakeUser_0()))
          as _i5.Future<_i2.User>);
}
