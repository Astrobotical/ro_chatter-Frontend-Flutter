part of 'internet_state_cubit.dart';

class InternetStateState {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? subscription;

}

class InternetStateInitial extends InternetStateState {
  BuildContext? context;
}
