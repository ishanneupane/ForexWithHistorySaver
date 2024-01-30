import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  void _updateStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
          messageText: Text("CONNECT TO THE INTERNET"),
          backgroundColor: CupertinoColors.destructiveRed,
          snackStyle: SnackStyle.GROUNDED,
          duration: Duration(seconds: 5));
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
