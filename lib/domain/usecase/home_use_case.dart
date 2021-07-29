import 'package:awesome_app/commons/resource.dart';
import 'package:awesome_app/data/model/get_photos_response.dart';

abstract class HomeUseCase {
  Future<Resource<GetPhotosResponse>> getPhotos(int page);
}