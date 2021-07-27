class MemoryCache<T> {
  late T _value;
  late DateTime _lastUpdated;
  Duration _expiredAfter = Duration(minutes: 5);

  bool get isExpired => _lastUpdated.add(_expiredAfter).isBefore(DateTime.now());

  T get value => _value;

  void setValue(T value) {
    _value = value;
    _lastUpdated = DateTime.now();
  }

  void setExpiredAfter(Duration time) {
    _expiredAfter = time;
  }

  bool get isEmpty {
    if (_value == null) return true;
    else if (T is List) return (value as List).isEmpty;
    else return false;
  }
}
