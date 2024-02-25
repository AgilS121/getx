import 'package:get/get.dart';
import 'package:getx/data/response/status.dart';
import 'package:getx/models/Data/ReadResponseCRUD.dart';
import 'package:getx/repository/home/homeRepository.dart';

class HomeController extends GetxController {
  final HomeRepository _repository = HomeRepository();

  final rxRequestStatus = Rx<Status>(Status.LOADING);
  final RxList<ReadResponseCRUD> getAll = <ReadResponseCRUD>[].obs;

  void getAllApi(String token) async {
    try {
      rxRequestStatus.value = Status.LOADING;
      final response = await _repository.getAll(token);
      getAll.assignAll(response);

      print('Data yang diperoleh: $getAll');
      rxRequestStatus.value = Status.COMPLETED;
    } catch (e) {
      print('Error occurred: $e');
      rxRequestStatus.value = Status.ERROR;
    }
  }
}
