import 'package:dio/dio.dart';
import 'package:tv_shows/models/review.dart';
import 'package:tv_shows/net/auth_info.dart';
import 'package:tv_shows/net/auth_info_holder.dart';
import 'package:tv_shows/net/auth_info_interceptor.dart';
import 'package:tv_shows/net/error_extractor_interceptor.dart';
import 'package:tv_shows/net/requests/add_review.dart';
import 'package:tv_shows/net/requests/register_info.dart';
import 'package:tv_shows/net/requests/sign_in_info.dart';

import '../models/show.dart';
import '../models/user.dart';

class NetworkRepository {
  NetworkRepository() {
    final options = BaseOptions(baseUrl: 'https://tv-shows.infinum.academy');
    _dio = Dio(options);
    _dio.interceptors.add(AuthInfoInterceptor(authInfoHolder: AuthInfoHolder()));
    _dio.interceptors.add(ErrorExtractorInterceptor());

    // this.fetchShows().then((value) => {
    //
    //
    // }).onError((error, stackTrace) => null)
  }
  late final Dio _dio;

  void _hydrate_token(Headers headers) {
    var authInterceptor =
        _dio.interceptors.firstWhere((element) => element is AuthInfoInterceptor) as AuthInfoInterceptor;

    var holder = AuthInfoHolder();
    holder.authInfo = AuthInfo.fromHeaderMap(headers.map);
    authInterceptor.authInfoHolder = holder;
  }

  Future<User> registerUser(RegisterInfo info) async {
    final response = await _dio.post("/users", data: info.toJson());
    _hydrate_token(response.headers);

    return User.fromJson(response.data['user']);
  }

  Future<User> signInUser(SignInInfo info) async {
    final response = await _dio.post("/users/sign_in", data: info.toJson());

    _hydrate_token(response.headers);

    return User.fromJson(response.data['user']);
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
}
