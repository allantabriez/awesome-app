
import 'package:awesome_app/commons/resource.dart';
import 'package:awesome_app/data/model/get_photos_response.dart';
import 'package:awesome_app/domain/repository/repository.dart';
import 'package:awesome_app/domain/usecase/home_use_case.dart';

class HomeInteractor implements HomeUseCase{
  final Repository _repository;

  HomeInteractor(this._repository);

  @override
  Future<Resource<GetPhotosResponse>> getPhotos(int page) => _repository.getPhotos(page);

}