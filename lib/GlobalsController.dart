import 'package:get/get.dart';

class GlobalController extends GetxController {
  RxInt serviceIdState = 0.obs;

  void updateServiceIdState(int newValue) {
    serviceIdState.value = newValue;
  }
}
