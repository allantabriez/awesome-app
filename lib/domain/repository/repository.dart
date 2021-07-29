import 'package:awesome_app/data/model/get_photos_response.dart';

abstract class Repository {
  Future<GetPhotosResponse> getPhotos(int page);
  Future<bool> isConnected();
}