import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'internet_state_state.dart';

class InternetStateCubit extends Cubit<InternetStateState> {
  InternetStateCubit() : super(InternetStateInitial());
  BuildContext? context;

  void watchingConnection(BuildContext context) {
      state.subscription = Connectivity()
          .onConnectivityChanged
          .listen((List<ConnectivityResult> result) {
        if (result.contains(ConnectivityResult.wifi) ||
            result.contains(ConnectivityResult.mobile) ||
            result.contains(ConnectivityResult.ethernet)) {
          ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text('Internet connection available')));
        } 
        if(result.contains(ConnectivityResult.none)){
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('No internet connection')));
        }
      });
    }

  @override
  Future<void> close() {
    state.subscription?.cancel();
    return super.close();
  }
}
