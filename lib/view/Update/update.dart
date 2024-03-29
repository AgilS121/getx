// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getx/view_models/controllers/addViewModel.dart';
// import 'package:getx/view_models/controllers/updateViewModel.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UpdateView extends StatefulWidget {
//   @override
//   State<UpdateView> createState() => _UpdateViewState();
// }

// class _UpdateViewState extends State<UpdateView> {
//   final UpdateController _controller = Get.put(UpdateController());
//   final TextEditingController _title = TextEditingController();
//   final TextEditingController _details = TextEditingController();

//   late Future<String?> _getTokenFuture;
//   late String? _token;

//   @override
//   void initState() {
//     super.initState();
//     _getTokenFuture = _getToken();
//   }

//   Future<String?> _getToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('token');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final String storyId = Get.arguments as String;

//     return FutureBuilder<String?>(
//       future: _getTokenFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           _token = snapshot.data;
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('update Story'),
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextFormField(
//                     controller: _title,
//                     decoration: InputDecoration(labelText: 'Title'),
//                   ),
//                   SizedBox(height: 16),
//                   // _image != null
//                   //     ? Image.file(_image!)
//                   //     : ElevatedButton(
//                   //         onPressed: _selectImage,
//                   //         child: Text('Select Image'),
//                   //       ),
//                   TextFormField(
//                     controller: _details,
//                     decoration: InputDecoration(labelText: 'Details'),
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (_title.text.isNotEmpty && _details.text.isNotEmpty) {
//                         _controller.updateTask(
//                             _token!, _title.text, _details.text, storyId);
//                       } else {
//                         Get.snackbar('Error',
//                             'Please select an image and provide description');
//                       }
//                     },
//                     child: Text('update Story'),
//                   ),
//                   Text(storyId)
//                 ],
//               ),
//             ),
//           );
//         } else {
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('update Story'),
//             ),
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/models/Data/DetailResponseCRUD.dart';
import 'package:getx/view_models/controllers/addViewModel.dart';
import 'package:getx/view_models/controllers/detailViewModel.dart';
import 'package:getx/view_models/controllers/updateViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateView extends StatefulWidget {
  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  final UpdateController _controller = Get.put(UpdateController());
  final TextEditingController _title = TextEditingController();
  final TextEditingController _details = TextEditingController();

  late Future<String?> _getTokenFuture;
  late String? _token;

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

    return FutureBuilder<String?>(
      future: _getTokenFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _token = snapshot.data;

          // Mengambil detail task berdasarkan ID
          final detailTaskFuture =
              Get.put(DetailController()).getDetailTask(_token!, storyId);

          return FutureBuilder<DetailResponseCRUD>(
            future: detailTaskFuture,
            builder: (context, detailSnapshot) {
              if (detailSnapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Update Story'),
                  ),
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (detailSnapshot.hasError) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Update Story'),
                  ),
                  body: Center(
                    child: Text('Error: ${detailSnapshot.error}'),
                  ),
                );
              } else {
                final taskDetail = detailSnapshot.data;
                if (taskDetail != null) {
                  // Set nilai judul ke dalam TextEditingController
                  _title.text = taskDetail.title ?? '';
                  _details.text = taskDetail.details ?? '';

                  return Scaffold(
                    appBar: AppBar(
                      title: Text('Update Story'),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _title,
                            decoration: InputDecoration(labelText: 'Title'),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _details,
                            decoration: InputDecoration(labelText: 'Details'),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              if (_title.text.isNotEmpty &&
                                  _details.text.isNotEmpty) {
                                _controller.updateTask(_token!, _title.text,
                                    _details.text, storyId);
                              } else {
                                Get.snackbar('Error',
                                    'Please select an image and provide description');
                              }
                            },
                            child: Text('Update Story'),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('Update Story'),
                    ),
                    body: Center(
                      child: Text('No data available'),
                    ),
                  );
                }
              }
            },
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Update Story'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
