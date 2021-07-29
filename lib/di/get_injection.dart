import 'package:awesome_app/commons/error_handling/dio_error_handler.dart';
import 'package:awesome_app/commons/network_state.dart';
import 'package:awesome_app/data/network/api/api_interceptors.dart';
import 'package:awesome_app/data/network/remote_data_source.dart';
import 'package:awesome_app/data/network/remote_data_source_impl.dart';
import 'package:awesome_app/data/repository/repository_impl.dart';
import 'package:awesome_app/domain/repository/home_interactor.dart';
import 'package:awesome_app/domain/repository/repository.dart';
import 'package:awesome_app/domain/usecase/home_use_case.dart';
import 'package:awesome_app/presentation/detail/detail_provider.dart';
import 'package:awesome_app/presentation/home/home_provider.dart';
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
  useCaseModule();
  providerModule();
}

void networkModule() {
  getIt.registerSingleton(DioErrorHandler());
  getIt.registerSingleton(Connectivity());
  getIt.registerSingleton(injectDio());
  getIt.registerSingleton<RemoteDataSource>(
      RemoteDataSourceImpl(getIt(), getIt()));
  getIt.registerFactory<NetworkState>(() => NetworkStateImpl(getIt()));
}

void localModule() async {
  final sharedPref = await SharedPreferences.getInstance();
  getIt.registerSingleton(sharedPref);
  // getIt.registerSingleton<CachingSource>(CachingSourceImpl(getIt()));
  // getIt.registerSingleton(MemoryCache());
}

void repositoryModule() {
  getIt.registerSingleton<Repository>(
      RepositoryImpl(getIt(), getIt()));
}

void useCaseModule() {
  getIt.registerFactory<HomeUseCase>(() => HomeInteractor(getIt()));
}

void providerModule() {
  getIt.registerFactory(() => HomeProvider(getIt()));
  getIt.registerFactoryParam(
      (param1, param2) => DetailProvider(param1 as int));
}

Dio injectDio() {
  Dio _dio = new Dio();
  _dio.interceptors.add(new ApiInterceptors());
  _dio.options.baseUrl = 'https://api.pexels.com/v1/';
  return _dio;
}
