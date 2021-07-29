import 'package:awesome_app/commons/network_state.dart';
import 'package:awesome_app/data/caching/caching_source.dart';
import 'package:awesome_app/data/caching/memory_cache.dart';
import 'package:awesome_app/data/model/get_photos_response.dart';
import 'package:awesome_app/data/network/remote_data_source.dart';
import 'package:awesome_app/domain/repository/repository.dart';
import 'package:awesome_app/utils/constants.dart';

class RepositoryImpl implements Repository {
  final NetworkState _networkState;
  final RemoteDataSource _remoteSource;
  // final CachingSource _cachingSource;
  // final MemoryCache _memoryCache;

  RepositoryImpl(this._networkState, this._remoteSource);

  @override
  Future<GetPhotosResponse> getPhotos(int page) => _remoteSource.getPhotos(page);

  @override
  Future<bool> isConnected() => _networkState.isConnected;
}
