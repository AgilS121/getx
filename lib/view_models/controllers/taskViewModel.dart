import 'package:get/get.dart';
import 'package:getx/models/Data/PostResponseCRUD.dart';
import 'package:getx/repository/add/taskRepository.dart';

class TaskController extends GetxController {
  var postResponse = PostResponseCRUD().obs;
  var isLoading = false.obs;
  var task = Task().obs; // Properti Rx<Task>

  final TaskRepository _taskRepository = TaskRepository();

  void createTask(Task task, String token) async {
    try {
      isLoading(true);
      postResponse.value = await _taskRepository.createTask(task, token);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
