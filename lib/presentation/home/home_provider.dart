import 'package:awesome_app/commons/resource.dart';
import 'package:awesome_app/data/model/get_photos_response.dart';
import 'package:awesome_app/domain/usecase/home_use_case.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final HomeUseCase _homeUseCase;

  late Resource<GetPhotosResponse> _state;
  List<Photo> _list = List.empty();
  late int? _nextPage;
  bool _isGrid = false;

  Resource<GetPhotosResponse> get state => _state;

  List<Photo> get list => _list;

  int? get nextPage => _nextPage;

  bool get isGrid => _isGrid;

  HomeProvider(this._homeUseCase) {
    getFirstPage();
  }

  void setListType() {
    _isGrid = !_isGrid;
    notifyListeners();
  }

  void getFirstPage() async {
    _state = Resource(null, true, null);
    notifyListeners();
    try {
      var response = await _homeUseCase.getPhotos(1);
      _list.addAll(response.data?.photos ?? List.empty());
      _state = response;
      response.data?.nextPage == null
          ? _nextPage = null
          : _nextPage = response.data!.page! + 1;
      notifyListeners();
    } catch (e) {
      _state = Resource(null, false, e.toString());
      notifyListeners();
    }
  }

  void getNextPage() async {
    _state = Resource(null, true, null);
    notifyListeners();
    try {
      var response = await _homeUseCase.getPhotos(_nextPage!);
      _list.addAll(response.data?.photos ?? List.empty());
      _state = response;
      response.data?.nextPage == null
          ? _nextPage = null
          : _nextPage = response.data!.page! + 1;
      notifyListeners();
    } catch (e) {
      _state = Resource(null, false, e.toString());
      notifyListeners();
    }
  }
}
