import 'package:get/get.dart';
import 'package:getx/repository/delete/deleteRepository.dart';

class DeleteController extends GetxController {
  final DeleteRepository _deleteRepository = DeleteRepository();

  Future<void> deleteTask(String token, String id) async {
    try {
      // Panggil repository untuk melakukan delete task
      await _deleteRepository.deleteTask(token, id);
      Get.snackbar('Success', 'Task deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task: $e');
    }
  }
}
