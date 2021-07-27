import 'dart:convert';

import 'package:awesome_app/data/caching/caching_source.dart';
import 'package:awesome_app/data/model/caching_model.dart';
import 'package:awesome_app/data/model/get_photos_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachingSourceImpl implements CachingSource {
  final SharedPreferences _sharedPreferences;

  CachingSourceImpl(this._sharedPreferences);

  @override
  Future<List<Photo>> getPhotos(int page) {
    final jsonList = _sharedPreferences.getStringList(page.toString());
    if (jsonList != null)
      return Future.value(
          jsonList.map((item) => Photo.fromJson(jsonDecode(item))).toList());
    else
      return Future.value(List.empty());
  }

  @override
  Future<void> savePhotos(int page, List<Photo> data) async {
    final jsonList = data.map((item) => jsonEncode(item.toJson())).toList();
    _sharedPreferences.setStringList(page.toString(), jsonList);
  }

  @override
  Future<String> getLastUpdated() {
    // TODO: implement getLastUpdated
    throw UnimplementedError();
  }

  @override
  Future<void> setLastUpdated(int dateTime) {
    // TODO: implement setLastUpdated
    throw UnimplementedError();
  }
}
