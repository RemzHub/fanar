import 'dart:developer';

import 'package:fanar/core/constants/app_text.dart';
import 'package:fanar/core/time/time_manager.dart';
import 'package:dio/dio.dart';

enum HttpMethod { get, post, delete }

enum RequestState { loading, done, error }

class CustomHttpClient {
  // Private constructor
  CustomHttpClient._internal() {
    dio = Dio();
  }

  // Private static instance of the class
  static final CustomHttpClient _instance = CustomHttpClient._internal();

  // Dio instance
  late Dio dio;

  // Factory constructor to return the single instance
  factory CustomHttpClient() {
    return _instance;
  }

  Map<String, String> header = {
    'Accept': 'application/json',
  };

  Map<String, String> headerWithAuth = {
    'Accept': 'application/json',
    'Authorization': 'Bearer'
  };

  bool validateStatus(status) {
    switch (status) {
      case 200:
      case 201:
      case 400:
      case 401:
      case 404:
      case 422:
        return true;
    }
    return false;
  }

  Future<void> request({
    required String url,
    HttpMethod httpMethod = HttpMethod.get,
    Map<String, String>? body,
    bool withAuth = false,
    required Function(Response response) onSuccess,
    required Function(DioException error) onError,
    bool showResult = false,
  }) async {
    final headers = withAuth ? headerWithAuth : header;
    final options = Options(headers: headers, validateStatus: validateStatus);

    try {
      late Response result;
      switch (httpMethod) {
        case HttpMethod.get:
          result = await dio.get(
            url,
            options: options,
          );

        case HttpMethod.post:
          result = await dio.post(
            url,
            data: body,
            options: options,
          );

        case HttpMethod.delete:
          result = await dio.delete(
            url,
            data: body,
            options: options,
          );
      }

      onSuccess(result);
      if (showResult) showResultData(result, url);
    } on DioException catch (error) {
      handleDioError(error, url, body);
      onError(error);
    } catch (error) {
      log('${AppText.somethingWrong}: $error');
    }
  }

  void showResultData(Response response, String url) {
    log('${AppText.dash24} ${AppText.requestDone} ${AppText.dash24}');
    log('${AppText.dateTime} ${TimeManager.instance.timeNow()}');
    log(AppText.requestSent(url));
    log('Status code: ${response.statusCode}');
    log('Status date: ${response.data}');
    log(AppText.dash64);
  }
}

void handleDioError(
  DioException e,
  String url,
  Map<String, String>? body,
) {
  log('${AppText.dash24} ${AppText.requestError} ${AppText.dash24}');
  log('${AppText.dateTime} ${TimeManager.instance.timeNow()}');
  log(AppText.requestSent(url));
  log(AppText.requestBody(body.toString()));
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      log(AppText.connectionTimeout);
      break;
    case DioExceptionType.sendTimeout:
      log(AppText.sendTimeout);
      break;
    case DioExceptionType.receiveTimeout:
      log(AppText.receiveTimeout);
      break;
    case DioExceptionType.badCertificate:
      log(AppText.badCertificate);
      break;
    case DioExceptionType.badResponse:
      log(AppText.badResponse);
      break;
    case DioExceptionType.cancel:
      log(AppText.cancel);
      break;
    case DioExceptionType.connectionError:
      log(AppText.connectionError);
      break;
    case DioExceptionType.unknown:
      log(AppText.unknown);
      break;
  }
  log(AppText.dash64);
}
