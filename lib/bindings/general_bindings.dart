import 'package:finanseeup/utils/network%20manager/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings
{

  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}