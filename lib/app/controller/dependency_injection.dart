import 'package:get/get.dart';
import 'package:hh/app/controller/network_checker.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
