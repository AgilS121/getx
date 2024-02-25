import 'dart:io';
import 'package:get/get.dart';
import 'package:getx/repository/add/addDataRepository.dart';

class AddDataController extends GetxController {
  final AddDataRepository _repository = AddDataRepository();

  Future<void> uploadStory(
      String token, String title, String description) async {
    try {
      bool isSuccess = await _repository.uploadStory(token, title, description);
      if (isSuccess) {
        Get.snackbar('Success', 'Story uploaded successfully');
      } else {
        Get.snackbar('Error', 'Failed to upload story');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
