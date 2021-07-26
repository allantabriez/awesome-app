import 'package:awesome_app/commons/network_state.dart';
import 'package:awesome_app/commons/resource.dart';
import 'package:awesome_app/data/model/get_photos_response.dart';
import 'package:awesome_app/data/network/remote_data_source.dart';
import 'package:awesome_app/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final NetworkState _networkState;
  final RemoteDataSource _remoteSource;

  RepositoryImpl(this._networkState, this._remoteSource);

  @override
  Future<Resource<Photo>> getPhoto(int id) {
    // TODO: implement getPhoto
    throw UnimplementedError();
  }

  @override
  Future<Resource<GetPhotosResponse>> getPhotos(int page) {
    // TODO: implement getPhotos
    throw UnimplementedError();
  }
}