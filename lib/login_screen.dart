import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/index.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ConnectivityBloc connectivityBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ConnectivityBloc, ConnectivityState>(
        bloc: connectivityBloc,
        builder: (context, state) {
          if (state is InternetUnAvailable) {
            return Container(
              child: Center(child: Text('No Internet')),
            );
          }

          if (state is InternetAvailable) {
            return Container(
              child:
                  Center(child: Text('You have internet access, keep going')),
            );
          }
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    connectivityBloc = BlocProvider.of<ConnectivityBloc>(context);
    super.initState();
  }
}
