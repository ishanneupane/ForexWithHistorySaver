import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  static const String noInternetMessage = "CONNECT TO THE INTERNET";

  @override
  void onInit() {
    super.onInit();
    _connectivity.checkConnectivity().then(_updateStatus);
    _connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  void _updateStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
        messageText: const Text(noInternetMessage),
        backgroundColor: CupertinoColors.destructiveRed,
        snackStyle: SnackStyle.GROUNDED,
        duration: const Duration(seconds: 5000),
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
