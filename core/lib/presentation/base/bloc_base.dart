part of 'base.dart';

abstract class AppBlocBase<E, S> extends Bloc<E, S> {
  late final appApiService = injector.get<AppApiService>();

  Function(ErrorData)? errorHandler;

  LocalDataManager get localDataManager => injector.get();

  AppBlocBase(S s) : super(s);

  void updateHeader(Map<String, String> headers) {
    appApiService.updateHeaders(headers: headers);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (error is OperationException) {
      final glError = error.graphqlErrors.firstOrNull;
      errorHandler?.call(
        ErrorData.fromGraplQL(
          error: GraphQLException.fromJson({
            'message': glError?.message,
            'locations': glError?.locations,
            'path': glError?.path,
            'extensions': glError?.extensions,
          }),
          exception: error.linkException,
        ),
      );
    } else if (error is Exception) {
      errorHandler?.call(
        ErrorData.fromGraplQL(exception: error),
      );
    } else {
      LogUtils.e('onError', error, stackTrace);
      super.onError(error, stackTrace);
    }
  }
}
