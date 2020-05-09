import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';

import 'index.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  StreamSubscription subscription;

  @override
  ConnectivityState get initialState => AppStarted();

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }

  @override
  Stream<Transition<ConnectivityEvent, ConnectivityState>> transformEvents(Stream<ConnectivityEvent> events, transitionFn) {
    // TODO: implement transformEvents
    final defferedEvents = events
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .switchMap(transitionFn);
    final forwardedEvents = events
        .asyncExpand(transitionFn);
    return forwardedEvents.mergeWith([defferedEvents]);
  }

  // @override
  // Stream<ConnectivityState> transformEvents(
  //   Stream<ConnectivityEvent> events,
  //   Stream<ConnectivityState> Function(ConnectivityEvent event) next,
  // ) {
  //   return super.transformEvents(
  //     events.debounceTime(
  //       const Duration(milliseconds: 500),
  //     ),
  //     next,
  //   );
  // }
  

  @override
  Stream<ConnectivityState> mapEventToState(ConnectivityEvent event) async* {
    final ConnectivityState currentState = state;

    if (currentState is AppStarted) {
      subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult connectivityResult) {
        // Got a new connectivity status!
        if (connectivityResult == ConnectivityResult.mobile) {
          InternetAvailable();
          return true;
        } else if (connectivityResult == ConnectivityResult.wifi) {
          InternetAvailable();
          return true;
        } else {
          InternetUnAvailable();
          return false;
        }
      });
    }
  }
}
