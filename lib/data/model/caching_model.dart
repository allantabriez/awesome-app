class CachingModel<T> {
  CachingModel({
    required this.data,
    required this.lastUpdated
});
  T data;
  DateTime lastUpdated;
  Duration expiredAfter = Duration(minutes: 5);
}