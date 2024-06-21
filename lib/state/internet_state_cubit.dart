import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'internet_state_state.dart';

class InternetStateCubit extends Cubit<InternetStateState> {
  InternetStateCubit() : super(InternetStateInitial(context: null));
}
