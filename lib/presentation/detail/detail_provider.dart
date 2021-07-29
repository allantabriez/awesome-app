
import 'package:awesome_app/domain/usecase/detail_use_case.dart';
import 'package:flutter/material.dart';

class DetailProvider extends ChangeNotifier {
  final DetailUseCase _detailUseCase;
  final int id;

  DetailProvider(this._detailUseCase, this.id){
    getDetails(id);
  }

  void getDetails(int id) async {
    var response = await _detailUseCase.getPhotos(id);
  }
}