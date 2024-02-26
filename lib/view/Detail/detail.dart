// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:getx/view_models/controllers/detailViewModel.dart';
// import 'package:getx/view_models/services/detailService.dart';

// class DetailPage extends StatefulWidget {
//   final String jwtToken;
//   final String storyId;

//   DetailPage({required this.jwtToken, required this.storyId});

//   @override
//   _DetailPageState createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   final _detailController = Get.put(DetailController());
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Story Detail'),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Image.network(
//                   //   _storyDetail['photoUrl'],
//                   //   height: 200,
//                   //   width: double.infinity,
//                   //   fit: BoxFit.cover,
//                   // ),
//                   SizedBox(height: 16),
//                   Text(
//                     _detailController.,
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     _detailController['description'],
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 16),
//                   // Text(
//                   //   'Created At: ${_storyDetail['createdAt']}',
//                   //   style: TextStyle(fontSize: 14),
//                   // ),
//                   // SizedBox(height: 8),
//                   // Text(
//                   //   'Location: ${_storyDetail['lat']}, ${_storyDetail['lon']}',
//                   //   style: TextStyle(fontSize: 14),
//                   // ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/models/Data/DetailResponseCRUD.dart';
import 'package:getx/view_models/controllers/detailViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatefulWidget {
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final DetailController detailController = Get.put(DetailController());
  late Future<String?> _getTokenFuture;
  String? _token;

  @override
  void initState() {
    super.initState();
    _getTokenFuture = _getToken();
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    final String storyId = Get.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Detail'),
      ),
      body: FutureBuilder<String?>(
        future: _getTokenFuture,
        builder: (context, tokenSnapshot) {
          if (tokenSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (tokenSnapshot.hasError) {
            return Center(
              child: Text('Error: ${tokenSnapshot.error}'),
            );
          } else {
            _token = tokenSnapshot.data;
            if (_token == null) {
              // Handle case where token is null
              return Center(
                child: Text('Token is null'),
              );
            } else {
              return FutureBuilder<DetailResponseCRUD>(
                future: detailController.getDetailTask(_token!, storyId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    final taskDetail = snapshot.data;
                    return taskDetail != null
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Title: ${taskDetail.title}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Details: ${taskDetail.details}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Created By: ${taskDetail.createdBy}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Text('No data available'),
                          );
                  }
                },
              );
            }
          }
        },
      ),
    );
  }
}
