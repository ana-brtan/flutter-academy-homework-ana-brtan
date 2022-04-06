import 'dart:async';

import 'package:dio/dio.dart';
import 'package:tv_shows/models/review.dart';
import 'package:tv_shows/net/auth_info.dart';
import 'package:tv_shows/net/auth_info_interceptor.dart';
import 'package:tv_shows/net/error_extractor_interceptor.dart';
import 'package:tv_shows/net/requests/add_review.dart';
import 'package:tv_shows/net/requests/register_info.dart';
import 'package:tv_shows/net/requests/sign_in_info.dart';
import 'package:tv_shows/net/requests/update_email.dart';
import 'package:tv_shows/net/storage_repository.dart';

import '../models/show.dart';
import '../models/user.dart';

class NetworkRepository {
  NetworkRepository(StorageRepository holder) {
    final options = BaseOptions(baseUrl: 'https://tv-shows.infinum.academy');
    _dio = Dio(options);
    _dio.interceptors.add(AuthInfoInterceptor());
    _dio.interceptors.add(ErrorExtractorInterceptor());

    // this.fetchShows().then((value) => {
    //
    //
    // }).onError((error, stackTrace) => null)
  }
  late final Dio _dio;

  Future<User> registerUser(RegisterInfo info) async {
    final response = await _dio.post("/users", data: info.toJson());
    var userJson = response.data['user'];
    await StorageRepository.storeUser(userJson);
    await StorageRepository.setAuthInfo(AuthInfo.fromHeaderMap(response.headers.map));
    return User.fromJson(userJson);
  }

  Future<User> signInUser(SignInInfo info) async {
    final response = await _dio.post("/users/sign_in", data: info.toJson());
    var userJson = response.data['user'];
    await StorageRepository.storeUser(userJson);
    await StorageRepository.setAuthInfo(AuthInfo.fromHeaderMap(response.headers.map));
    return User.fromJson(userJson);
  }

  Future<List<Show>> fetchShows() async {
    final response = await _dio.get('/shows');
    var l = response.data['shows'] as Iterable;
    return List<Show>.from(l.map((model) => Show.fromJson(model)));
  }

  Future<List<Review>> fetchShowReviews(String showID) async {
    final response = await _dio.get("/shows/$showID/reviews");
    var rawReviews = response.data['reviews'] as Iterable;
    return List<Review>.from(rawReviews.map((elem) => Review.fromJson(elem)));
  }

  Future<Review> addShowReview(AddReview body) async {
    final response = await _dio.post("/reviews", data: body.toJson());
    var rawReview = response.data['review'];
    return Review.fromJson(rawReview);
  }

  Future<User> updateEmail(UpdateEmail body) async {
    final response = await _dio.put("/users", data: body.ToJson());
    var userJson = response.data['user'];
    await StorageRepository.storeUser(userJson);
    return User.fromJson(userJson);
  }

  Future<User> updateProfilePhoto(String imagePath) async {
    var formData = FormData.fromMap({'image': await MultipartFile.fromFile(imagePath)});
    var response = await _dio.put("/users", data: formData);
    var userJson = response.data['user'];
    await StorageRepository.storeUser(userJson);
    return User.fromJson(userJson);
  }
}
