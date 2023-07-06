import 'package:connectivity_plus/connectivity_plus.dart';
import 'internet_error.dart';

/// Check if user has an internet or not
///
/// Return: [true] if connected either mobile or wifi, [false] otherwise
Future<bool> hasInternet() async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    // Connected to a mobile network.
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // Connected to a wifi network.
    return true;
  } else {
    internetErrorOverlay();
    return false;
  }
}
