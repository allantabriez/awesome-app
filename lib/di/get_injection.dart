
import 'package:awesome_app/commons/error_handling/dio_error_handler.dart';
import 'package:awesome_app/commons/network_state.dart';
import 'package:awesome_app/data/caching/caching_source.dart';
import 'package:awesome_app/data/caching/caching_source_impl.dart';
import 'package:awesome_app/data/caching/memory_cache.dart';
import 'package:awesome_app/data/network/api/api_interceptors.dart';
import 'package:awesome_app/data/network/remote_data_source.dart';
import 'package:awesome_app/data/network/remote_data_source_impl.dart';
import 'package:awesome_app/data/repository/repository_impl.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> inject() async {
  WidgetsFlutterBinding.ensureInitialized();
  localModule();
  networkModule();
  repositoryModule();
}

void networkModule() async {
  getIt.registerSingleton(DioErrorHandler());
  getIt.registerSingleton(Connectivity());
  getIt.registerSingleton(injectDio());
  getIt.registerSingleton<RemoteDataSource>(RemoteDataSourceImpl(getIt(), getIt()));
  getIt.registerFactory<NetworkState>(() => NetworkStateImpl(getIt()));
}

void localModule() async {
  final sharedPref = await SharedPreferences.getInstance();
  getIt.registerSingleton(sharedPref);
  getIt.registerSingleton<CachingSource>(CachingSourceImpl(getIt()));
  getIt.registerSingleton(MemoryCache());
}

void repositoryModule() async {
  getIt.registerSingleton(RepositoryImpl(getIt(), getIt(), getIt(), getIt()));
}

Dio injectDio() {
  Dio _dio = new Dio();
  _dio.interceptors.add(new ApiInterceptors());
  _dio.options.baseUrl = 'https://api.pexels.com/v1/';
  _dio.options.connectTimeout = 10000;
  _dio.options.receiveTimeout = 10000;
  return _dio;
}