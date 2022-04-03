import 'package:dio/dio.dart';
import 'package:tv_shows/net/auth_info_holder.dart';

class AuthInfoInterceptor extends Interceptor {
  AuthInfoHolder authInfoHolder;

  AuthInfoInterceptor({required this.authInfoHolder});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (authInfoHolder.authInfo != null) {
      options.headers = authInfoHolder.authInfo?.toHeaders();
    }

    super.onRequest(options, handler);
  }
}
