import 'package:awesome_app/commons/resource.dart';
import 'package:awesome_app/data/model/get_photos_response.dart';

abstract class RemoteDataSource {
  Future<Resource<GetPhotosResponse>> getPhotos(int page);
  Future<Resource<Photo>> getPhoto(int id);
}