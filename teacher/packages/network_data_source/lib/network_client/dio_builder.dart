import 'package:core/core.dart';

class DioBuilder {
  const DioBuilder._();

  static Dio createDio({
    List<Interceptor> interceptors = const [],
  }) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.addAll(interceptors);

    return dio;
  }
}
