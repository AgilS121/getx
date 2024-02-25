import 'dart:convert';
import 'package:getx/models/Data/PostResponseCRUD.dart';
import 'package:getx/res/url/appUrl.dart';
import 'package:http/http.dart' as http;

class TaskRepository {
  Future<PostResponseCRUD> createTask(Task task, String token) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Add authorization token here
    };

    final response = await http.post(
      Uri.parse(AppUrl.post),
      headers: headers,
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode == 200) {
      return PostResponseCRUD.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create task: ${response.reasonPhrase}');
    }
  }
}
