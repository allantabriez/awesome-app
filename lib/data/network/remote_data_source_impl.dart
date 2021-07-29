import 'package:awesome_app/commons/error_handling/dio_error_handler.dart';
import 'package:awesome_app/commons/resource.dart';
import 'package:awesome_app/data/model/get_photos_response.dart';
import 'package:awesome_app/data/network/remote_data_source.dart';
import 'package:dio/dio.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio _dio;
  final DioErrorHandler _errorHandler;

  RemoteDataSourceImpl(this._dio, this._errorHandler);

  @override
  Future<Resource<Photo>> getPhoto(int id) async {
    try {
      var response = await _dio.get('photos/$id');
      if (response.statusCode == 200) {
        var data = Photo.fromJson(response.data);
        return Resource(data, false, null);
      }
      return Resource(null, false, response.statusMessage);
    } on DioError catch (ex) {
      _errorHandler.handleError(ex);
      return Resource(null, false, ex.message);
    }
  }

  @override
  Future<Resource<GetPhotosResponse>> getPhotos(int page) async {
    try {
      var response = await _dio.get('curated', queryParameters: {
        'page': page,
        'per_page': 30,
      });
      if (response.statusCode == 200) {
        var data = GetPhotosResponse.fromJson(response.data);
        return Resource(data, false, null);
      }
      return Resource(null, false, response.statusMessage);
    } on DioError catch (ex) {
      _errorHandler.handleError(ex);
      return Resource(null, false, ex.message);
    }
  }
}
