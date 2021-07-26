import 'package:dio/dio.dart';

class DioErrorHandler {
  void handleError(DioError ex) {
    print(ex.error.toString());
    print(ex.message);
    throw new Exception(ex.message);
  }
}