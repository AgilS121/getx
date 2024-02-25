import 'package:get/get.dart';
import 'package:getx/models/Data/UpdateResponseCRUD.dart';
import 'package:getx/repository/update/updateRepository.dart';

class UpdateController extends GetxController {
  final UpdateDataRepository _updateDataRepository = UpdateDataRepository();

  Future<void> updateTask(
      String token, String title, String details, String id) async {
    try {
      UpdateResponseCRUD response =
          await _updateDataRepository.updateTask(token, title, details, id);
      if (response.status == true) {
        Get.snackbar('Success', 'Task updated successfully');
      } else {
        Get.snackbar('Error', 'Failed to update task');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task: $e');
    }
  }
}
