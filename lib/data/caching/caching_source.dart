import 'dart:core';
import 'package:awesome_app/data/model/caching_model.dart';
import 'package:awesome_app/data/model/get_photos_response.dart';

abstract class CachingSource {
  Future<List<Photo>> getPhotos(int page);

  Future<void> savePhotos(int page, List<Photo> data);

  Future<String> getLastUpdated();

  Future<void> setLastUpdated(int dateTime);
}