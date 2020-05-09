import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/index.dart';
import 'login_screen.dart';
import 'util/internet_check.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyHomePage());
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, }) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<InternetCheck>(
          create: (context) => InternetCheck(),
          lazy: true,
        ),
      ], 
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ConnectivityBloc>(
            create: (context) {
              return ConnectivityBloc();
            },
          ),
        ], 
        child: MaterialApp(
          title: 'Connectivity',
          home: LoginScreen(),
        )));
  }
}


class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}