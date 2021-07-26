import 'package:connectivity/connectivity.dart';

abstract class NetworkState {
  Future<bool> get isConnected;
}

class NetworkStateImpl implements NetworkState {
  final Connectivity connectivity;

  NetworkStateImpl(this.connectivity);

  @override
  Future<bool> get isConnected  async {
    var result = await connectivity.checkConnectivity();
    return result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;
  }
}