import 'package:get/get.dart';

class DataController extends GetxController {
  var apiData = {}.obs; // Initialize as an empty map

  void updateData(Map<dynamic, dynamic> newData) {
    apiData.value = newData;
  }
}
