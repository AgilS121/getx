import 'package:get/get.dart';
import 'package:getx/data/response/status.dart';
import 'package:getx/models/home/GetAllList.dart';
import 'package:getx/repository/home/homeRepository.dart';

class HomeController extends GetxController {
  final HomeRepository _repository = HomeRepository();

  final rxRequestStatus = Rx<Status>(Status.LOADING);
  final getAll = Rx<GetAllListModel?>(null);

  // Menambahkan parameter token pada fungsi getAllApi
  void getAllApi(String token) async {
    try {
      rxRequestStatus.value = Status.LOADING;
      final response = await _repository.getAll(token); // Mengirim token ke repository
      getAll.value = response;
      rxRequestStatus.value = Status.COMPLETED;
    } catch (e) {
      print('Error occurred: $e');
      rxRequestStatus.value = Status.ERROR;
    }
  }
}
