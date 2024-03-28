// import 'dart:io';

// import 'package:dartx/dartx.dart';
// import 'package:dio/dio.dart' as dio_p;
// import 'package:flutter/foundation.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:injectable/injectable.dart';
// import 'package:pedantic/pedantic.dart';

// import '../../../common/components/graphql/graphql.dart';
// import '../../../common/config.dart';
// import '../../../common/constants.dart';
// import '../../../common/services/auth_service.dart';
// import '../../../common/utils.dart';
// import '../../../di/di.dart';
// // import '../../models/graphql_error.dart';
// // import '../local/local_data_manager.dart';
// import 'interceptor/auth_interceptor.dart';
// import 'interceptor/logger_interceptor.dart';
// import 'repository/rest_api_repository/api_contract.dart';
// import 'repository/rest_api_repository/rest_api_repository.dart';

// part 'api_service_error.dart';

// @Injectable()
// class AppApiService {
//   late dio_p.Dio dio;
//   late RestApiRepository client;
//   late GraphQLClient graphQLClient;
//   ApiServiceDelegate? apiServiceDelegate;

//   /// Cached headers for GraphQl will get headers from lastest `updateHeaders`
//   late Map<String, String> _cacheHeaders;

//   // LocalDataManager get localDataManager => injector.get();

//   AppApiService() {
//     _initialize();
//   }

//   void _initialize() {
//     _cacheHeaders = _getDefaultHeader();

//     // _createGraphQLClient();

//     _setupDioClient();

//     _createRestClient();
//   }

//   Map<String, String> _getDefaultHeader() {
//     final defaultHeader = <String, String>{
//       HttpConstants.contentType: 'application/json',
//     };

//     if (!kIsWeb) {
//       defaultHeader[HttpConstants.osplatform] = Platform.operatingSystem;
//       defaultHeader[HttpConstants.apiKey] =
//           Config.instance.appConfig.graphqlApiKey;
//     }
//     return defaultHeader;
//   }

//   void updateHeaders({Map<String, String> headers = const {}}) {
//     final defaultHeader = _getDefaultHeader();

//     final _headers = <String, String>{
//       ...defaultHeader,
//       ...headers,
//     };

//     dio.options.headers.clear();

//     dio.options.headers = _headers;

//     _cacheHeaders = _headers;
//   }

//   // void _createGraphQLClient() {
//   //   graphQLClient = createGraphQLClient(
//   //     baseUri: Config.instance.appConfig.baseGraphQLUrl,
//   //     socketUrl: Config.instance.appConfig.graphqlSocketUrl,
//   //     getToken: () async {
//   //       final token = injector.get<AuthService>().token;
//   //       return token.isNotNullOrEmpty ? 'jwt $token' : null;
//   //     },
//   //     onError: (err, exception) {
//   //       final error = GraphQLException.fromJson({
//   //         'message': err?.message,
//   //         'locations': err?.locations,
//   //         'path': err?.path,
//   //         'extensions': err?.extensions,
//   //       });
//   //       if (apiServiceDelegate != null) {
//   //         apiServiceDelegate?.onError(ErrorData.fromGraplQL(
//   //           error: error,
//   //           exception: exception,
//   //         ));
//   //       }
//   //     },

//   //     /// Remove old `authorization` bcs of GraphQl will get new from `getToken`
//   //     headers: _getDefaultHeader()..remove(HttpConstants.authorization),
//   //     customHeaderFnc: () {
//   //       return {..._cacheHeaders}..remove(HttpConstants.authorization);
//   //     },
//   //     onRefreshToken: refreshToken,
//   //   );
//   // }

//   void _setupDioClient() {
//     dio = dio_p.Dio(dio_p.BaseOptions(
//       followRedirects: false,
//       receiveTimeout: const Duration(seconds: 30),
//       sendTimeout: const Duration(seconds: 30),
//     ));

//     dio.options.headers.clear();

//     dio.options.headers = _getDefaultHeader();

//     /// Dio InterceptorsWrapper
//     dio.interceptors.add(
//       AuthInterceptor(
//         getToken: () {
//           final token = injector.get<AuthService>().token;
//           return token.isNotNullOrEmpty ? 'jwt $token' : null;
//         },
//         refreshToken: (token, options) async {
//           return refreshToken(
//             token,
//             saveToken: options.path != ApiContract.logout,
//           );
//         },
//         onLogoutRequest: () {
//           // unawaited(localDataManager.clearData());
//         },
//         refreshTokenPath: ApiContract.refreshToken,
//         logoutPath: ApiContract.logout,
//       ),
//     );
//     dio.interceptors.add(
//       LoggerInterceptor(
//         onRequestError: (error) => apiServiceDelegate?.onError(
//           ErrorData.fromDio(error),
//         ),
//         ignoreReponseDataLog: (response) {
//           // return response.requestOptions.path == ApiContract.administrative;
//           return false;
//         },
//       ),
//     );
//   }

//   void _createRestClient() {
//     client = RestApiRepository(
//       dio,
//       baseUrl: Config.instance.appConfig.baseApiLayer,
//     );
//   }

//   Future<String?> refreshToken(String token, {bool saveToken = true}) async {
//     final token = await injector.get<AuthService>().refreshToken();
//     return token.isNotNullOrEmpty ? 'jwt $token' : null;
//   }
// }

// mixin ApiServiceDelegate {
//   void onError(ErrorData onError);
// }
