import 'package:awesome_app/commons/result_state.dart';
import 'package:awesome_app/data/model/get_photos_response.dart';
import 'package:awesome_app/domain/usecase/home_use_case.dart';
import 'package:awesome_app/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final HomeUseCase _homeUseCase;

  ResultState _state = ResultState.Loading;
  late String _message;
  List<Photo> _list = List.empty(growable: true);
  late int? _nextPage;
  bool _isGrid = false;

  ResultState get state => _state;

  String get message => _message;

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
    _state = ResultState.Loading;
    notifyListeners();
    try {
      var isConnected = await _homeUseCase.isConnected();
      if (isConnected) {
        var response = await _homeUseCase.getPhotos(1);
        _list.addAll(response.photos ?? List.empty(growable: true));
        // _list = response.photos ?? List.empty(growable: true);
        _state = ResultState.HasData;
        response.nextPage == null
            ? _nextPage = null
            : _nextPage = response.page! + 1;
        notifyListeners();
      } else {
        _state = ResultState.NoConnection;
        _message = NO_CONNECTION;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = e.toString();
      notifyListeners();
    }
  }

  void getNextPage() async {
    _state = ResultState.Loading;
    notifyListeners();
    try {
      var isConnected = await _homeUseCase.isConnected();
      if (isConnected) {
        var response = await _homeUseCase.getPhotos(_nextPage!);
        _list.addAll(response.photos ?? List.empty(growable: true));
        _state = ResultState.HasData;
        response.nextPage == null
            ? _nextPage = null
            : _nextPage = response.page! + 1;
        notifyListeners();
      } else {
        _state = ResultState.NoConnection;
        _message = NO_CONNECTION;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
