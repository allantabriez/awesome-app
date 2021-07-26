
import 'package:awesome_app/commons/error_handling/dio_error_handler.dart';
import 'package:awesome_app/commons/network_state.dart';
import 'package:awesome_app/data/network/api/api_interceptors.dart';
import 'package:awesome_app/data/network/remote_data_source.dart';
import 'package:awesome_app/data/network/remote_data_source_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> inject() async {
  WidgetsFlutterBinding.ensureInitialized();
  networkModule();
}

void networkModule() async {
  getIt.registerSingleton(DioErrorHandler());
  getIt.registerSingleton(injectDio());
  getIt.registerSingleton<RemoteDataSource>(RemoteDataSourceImpl(getIt(), getIt()));
  getIt.registerFactory<NetworkState>(() => NetworkStateImpl(getIt()));
}

Dio injectDio() {
  Dio _dio = new Dio();
  _dio.interceptors.add(new ApiInterceptors());
  _dio.options.baseUrl = 'https://api.pexels.com/v1/';
  _dio.options.connectTimeout = 10000;
  _dio.options.receiveTimeout = 10000;
  return _dio;
}