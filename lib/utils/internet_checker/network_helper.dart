import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:video_reel_app/utils/internet_checker/network_bloc.dart';
import 'package:video_reel_app/utils/internet_checker/network_event.dart';

/*This class is used to observe the network change and add event to the network
bloc.
*/
class NetworkHelper {
  static void observeNetwork() {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        NetworkBloc().add(const NetworkNotify());
      } else {
        NetworkBloc().add(const NetworkNotify(isConnected: true));
      }
    });
  }
}
