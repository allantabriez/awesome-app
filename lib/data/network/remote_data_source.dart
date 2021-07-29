import 'package:awesome_app/data/model/get_photos_response.dart';

abstract class RemoteDataSource {
  Future<GetPhotosResponse> getPhotos(int page);
}