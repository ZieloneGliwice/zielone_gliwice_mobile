import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../api.dart';

class ApiDio {
  final Dio dio = createDio();

  static Dio createDio() {
    final Dio dio = Dio(BaseOptions(
        receiveTimeout: const Duration(minutes: 1), // 15 seconds
        connectTimeout: const Duration(minutes: 1),
        sendTimeout: const Duration(minutes: 1),
      baseUrl: API.baseURL
        ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }
}

class AppInterceptors extends Interceptor {
  AppInterceptors(this.dio);
  final Dio dio;

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        throw RequestCancelledException(err.requestOptions);
      case DioErrorType.unknown:
      case DioErrorType.badCertificate:
      case DioErrorType.connectionError:
        throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'something_went_wrong'.tr;
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'something_went_wrong'.tr;
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'something_went_wrong'.tr;
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'something_went_wrong'.tr;
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'no_internet_connection'.tr;
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'something_went_wrong'.tr;
  }
}

class RequestCancelledException extends DioError {
  RequestCancelledException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'something_went_wrong'.tr;
  }
}
