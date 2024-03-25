// import 'package:injectable/injectable.dart';

// import '../../../../models/authentication.dart';
// import '../../data_repository.dart';
// import 'auth_repository.dart';

// @Singleton(as: AuthRepository)
// class AuthRepositoryImpl with DataRepository implements AuthRepository {
//   @override
//   Future<LoginResult?> loginWithOtp(
//     String otpCode,
//     int phoneCode,
//     String phoneNumber,
//   ) async {
//     const query = '''
//       mutation LoginWithOTP(\$data: LoginWithOTPInput!) {
//         loginWithOTP(data: \$data) {
//             access_token
//             expires_in
//             refresh_token
//             token_type
//           }
//         }
//     ''';
//     return graphqlProvider.mutate(
//       query,
//       LoginResult.fromJson,
//       'loginWithOTP',
//       variables: {
//         'data': {
//           'otp': otpCode,
//           'phone_code': phoneCode,
//           'phone_number': phoneNumber,
//         }
//       },
//     );
//   }

//   @override
//   Future<LoginResult?> refreshToken(
//     String accessToken,
//     String refreshToken,
//   ) async {
//     const query = '''
//       mutation RefreshToken(\$data: RefreshTokenInput!) {
//         refreshToken(data: \$data) {
//           access_token
//           expires_in
//           refresh_token
//           token_type
//         }
//       }
//     ''';
//     return graphqlProvider.mutate(
//       query,
//       LoginResult.fromJson,
//       'refreshToken',
//       variables: {
//         'isRefreshTokenApi': true,
//         'data': {
//           'access_token': accessToken,
//           'refresh_token': refreshToken,
//         }
//       },
//     );
//   }

//   @override
//   Future<RequestOtpResult?> requestOtp(
//     int phoneCode,
//     String phoneNumber,
//   ) async {
//     const query = '''mutation GetOTP(\$data: GetOTPInput!) {
//       getOTP(data: \$data) {
//         message
//         }
//       }''';
//     final result = await graphqlProvider.mutate(
//       query,
//       RequestOtpResult.fromJson,
//       'getOTP',
//       variables: {
//         'data': {
//           'phone_code': phoneCode,
//           'phone_number': phoneNumber,
//         }
//       },
//     );
//     return result;
//   }

//   @override
//   Future<LoginResult?> loginWithPassword(
//     int phoneCode,
//     String phoneNumber,
//     String password,
//   ) {
//     const query =
//         '''mutation LoginWithPassword(\$data: LoginWithPasswordInput!) {
//         loginWithPassword(data: \$data) {
//           access_token
//           expires_in
//           refresh_token
//           token_type
//         }
//       }''';
//     return graphqlProvider.mutate(
//       query,
//       LoginResult.fromJson,
//       'loginWithPassword',
//       variables: {
//         'data': {
//           'phone_code': phoneCode,
//           'phone_number': phoneNumber,
//           'password': password,
//         }
//       },
//     );
//   }

//   @override
//   Future<LoginResult?> registerTeacher() async {
//     throw UnimplementedError();
//   }

//   @override
//   Future<LoginResult?> updateTeacher() async {
//     throw UnimplementedError();
//   }

//   @override
//   Future<bool?> deleteAccount() {
//     const query = '''
//     mutation Mutation {
//       deleteAccount {
//         message
//       }
//     }
//     ''';
//     return graphqlProvider.mutate(
//       query,
//       (returning) => returning['message'] != null,
//       'deleteAccount',
//     );
//   }

//   @override
//   Future<bool?> changePassword(
//     String code,
//     int phoneCode,
//     String phoneNumber,
//     String password,
//   ) {
//     const query = '''
//       mutation changePassword(\$data:  LoginWithOTPInputChangePassword!) {
//          loginWithOTPAndChangePassword(data: \$data) {
//           access_token
//         }
//       }
//     ''';
//     return graphqlProvider.mutate(
//         query,
//         (returning) => returning['access_token'] != null,
//         'loginWithOTPAndChangePassword',
//         variables: {
//           'data': {
//             'otp': code,
//             'phone_code': phoneCode,
//             'phone_number': phoneNumber,
//             'password': password
//           }
//         });
//   }
// }
