
import 'package:awesome_app/commons/resource.dart';
import 'package:awesome_app/data/model/get_photos_response.dart';
import 'package:awesome_app/domain/repository/repository.dart';
import 'package:awesome_app/domain/usecase/detail_use_case.dart';

class DetailInteractor implements DetailUseCase {
  final Repository _repository;

  DetailInteractor(this._repository);

  @override
  Future<Resource<Photo>> getPhotos(int id) => _repository.getPhoto(id);
}