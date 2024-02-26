import 'package:get/get.dart';
import 'package:getx/models/Data/DetailResponseCRUD.dart';
import 'package:getx/repository/detail/detailRepository.dart';

class DetailController extends GetxController {
  final DetailRepository _detailRepository = DetailRepository();

  Future<DetailResponseCRUD> getDetailTask(String token, String id) async {
    try {
      final detail = await _detailRepository.detailTask(token, id);
      return detail;
    } catch (e) {
      throw Exception('Failed to get task detail: $e');
    }
  }
}
