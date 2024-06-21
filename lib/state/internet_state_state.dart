part of 'internet_state_cubit.dart';


sealed class InternetStateState {}

class InternetStateInitial extends InternetStateState {
  BuildContext? context;

  InternetStateInitial({required this.context}) {
    initState();
  }

  initState() {
    if (context == null) {
      StreamSubscription<List<ConnectivityResult>> subscription = Connectivity()
          .onConnectivityChanged.listen((List<ConnectivityResult> result) {
        if (result.contains(ConnectivityResult.none)) {
          ScaffoldMessenger.of(context!).showSnackBar(
              SnackBar(content: Text('No internet connection')));
        }
        else {
          ScaffoldMessenger.of(context!).showSnackBar(
              SnackBar(content: Text('Internet connection available')));
        }
      });
    }
  }
}
