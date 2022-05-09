part of services;

class Result<T> {
  final Response<T>? response;
  final Object? error;

  Result({this.response, this.error});
}

/// this interceptor will convert map into form map if map contain a `multi part file`
/// and this interceptor will assign errors to [onRegularError] or [onUnAuth Error]
class _CustomInterceptor extends Interceptor {
  final void Function(DioError)? onUnAuth;
  final void Function(DioError)? onRegularError;

  _CustomInterceptor({this.onRegularError, this.onUnAuth});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.data is List &&
        options.data.any((item) => item is MultipartFile)) {
      options.data = FormData.fromMap(options.data);
    }
    if (options.data is Map &&
        options.data.values.any((item) => item is MultipartFile)) {
      options.data = FormData.fromMap(options.data);
    }
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    onRegularError?.call(err);
    if ((err.response?.statusCode ?? 0) == 401) {
      onUnAuth?.call(err);
    }
    return handler.next(err);
  }
}

class DioService {
  /// this object is needed for doing actual requests
  final Dio dio;

  /// needed to printing messages in console every request
  /// messages is [headers, form, query parameters, endpoint, response and errors]
  late EasyLogger logger;

  void Function(DioError)? onUnauthenticatedResponseError;
  void Function(DioError)? onRegularError;

  DioService(
    this.dio, {
    this.onRegularError,
    this.onUnauthenticatedResponseError,
    EasyLogger? logger,
  }) {
    this.logger = logger ??
        EasyLogger(
          defaultLevel: LevelMessages.info,
          enableBuildModes: [BuildMode.debug],
          enableLevels: LevelMessages.values,
        );

    try {
      dio.interceptors.add(PrettyDioLogger(
        logPrint: this.logger,
        requestHeader: true,
        requestBody: true,
      ));

      dio.interceptors.add(_CustomInterceptor(
        onRegularError: onRegularError,
        onUnAuth: onUnauthenticatedResponseError,
      ));
    } catch (_) {}
  }

  Future<Result<T>> _fakeRequest<T>(T data) async {
    await Future.delayed(const Duration(seconds: 2));
    final response = Response<T>(
      requestOptions: RequestOptions(path: 'FAKE'),
      data: data,
    );
    logger.call('*' * 10);
    logger.call(
      'Fake Data: '
      '${json.encode(data)}',
    );
    logger.call('*' * 10);

    return Result(response: response);
  }

  Future<Result<T>> get<T>(
    String api, {
    Map<String, dynamic>? queryParameters,
    bool showLoading = false,
    T? fakeData,
  }) async =>
      _request(
        api,
        'GET',
        queryParameters: queryParameters,
        showLoading: showLoading,
        fakeData: fakeData,
      );

  Future<Result<T>> post<T>(
    String api, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool showLoading = false,
    T? fakeData,
  }) async =>
      _request(
        api,
        'POST',
        data: data,
        queryParameters: queryParameters,
        showLoading: showLoading,
        fakeData: fakeData,
      );

  Future<Result<T>> put<T>(
    String api, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool showLoading = false,
    T? fakeData,
  }) async =>
      _request(
        api,
        'PUT',
        data: data,
        queryParameters: queryParameters,
        showLoading: showLoading,
        fakeData: fakeData,
      );

  Future<Result<T>> patch<T>(
    String api, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool showLoading = false,
    T? fakeData,
  }) async =>
      _request(
        api,
        'PATCH',
        data: data,
        queryParameters: queryParameters,
        showLoading: showLoading,
        fakeData: fakeData,
      );

  Future<Result<T>> delete<T>(
    String api, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool showLoading = false,
    T? fakeData,
  }) async =>
      _request(
        api,
        'DELETE',
        data: data,
        queryParameters: queryParameters,
        showLoading: showLoading,
        fakeData: fakeData,
      );

  Future<Result<T>> _request<T>(
    String api,
    String method, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool showLoading = false,
    T? fakeData,
  }) async {
    try {
      try {
        if (showLoading) BotToast.showLoading();
      } catch (_) {}
      if (fakeData != null) return await _fakeRequest<T>(fakeData);
      final response = await dio.request<T>(
        api,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method),
      );
      return Result(response: response);
    } catch (e) {
      return Result(error: e);
    } finally {
      try {
        if (showLoading) BotToast.closeAllLoading();
      } catch (_) {}
    }
  }
}
