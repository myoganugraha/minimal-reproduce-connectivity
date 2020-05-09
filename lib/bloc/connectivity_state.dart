import 'package:equatable/equatable.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class AppStarted extends ConnectivityState {
  @override
  String toString() {
    // TODO: implement toString
    return 'AppStarted{}';
  }
}

class InternetAvailable extends ConnectivityState {
  @override
  String toString() {
    // TODO: implement toString
    return 'InternetAvailable{}';
  }
}

class InternetUnAvailable extends ConnectivityState {
  @override
  String toString() {
    // TODO: implement toString
    return 'InternetUnAvailable{}';
  }
}
