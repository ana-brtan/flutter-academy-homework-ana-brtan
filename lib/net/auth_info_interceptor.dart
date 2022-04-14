import 'package:dio/dio.dart';
import 'package:tv_shows/net/storage_repository.dart';

class AuthInfoInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var authInfo = await StorageRepository.getAuthInfo();

    if (authInfo != null) {
      options.headers = authInfo.toHeaders();
    }

    super.onRequest(options, handler);
  }
}
