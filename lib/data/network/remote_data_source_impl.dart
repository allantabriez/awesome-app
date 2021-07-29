import 'package:awesome_app/commons/error_handling/dio_error_handler.dart';
import 'package:awesome_app/data/model/get_photos_response.dart';
import 'package:awesome_app/data/network/remote_data_source.dart';
import 'package:dio/dio.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio _dio;
  final DioErrorHandler _errorHandler;

  RemoteDataSourceImpl(this._dio, this._errorHandler);

  @override
  Future<GetPhotosResponse> getPhotos(int page) async {
    try {
      var response = await _dio.get('curated', queryParameters: {
        'page': page,
        'per_page': 15,
      });
      return GetPhotosResponse.fromJson(response.data);
    } on DioError catch (ex) {
      _errorHandler.handleError(ex);
      throw Exception(ex.message);
    }
  }
}
