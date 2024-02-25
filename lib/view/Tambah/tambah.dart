// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getx/res/routes/routes_name.dart';
// import 'package:getx/view_models/services/uploadService.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class TambahPage extends StatefulWidget {

//   @override
//   _TambahPageState createState() => _TambahPageState();
// }

// class _TambahPageState extends State<TambahPage> {
//   final TextEditingController _deskripsiController = TextEditingController();
//   final picker = ImagePicker();
//   String imagePath = '';

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

//  Future<void> pickImageFromGallery() async {
//   final pickedFile = await picker.getImage(source: ImageSource.gallery);

//   if (pickedFile != null) {
//     File imageFile = File(pickedFile.path);
//     int fileSizeInBytes = imageFile.lengthSync();

//     if (fileSizeInBytes > 1048576) {
//       // Jika ukuran file lebih besar dari 1 MB, tampilkan alert
//       _showFileSizeAlert();
//     } else {
//       setState(() {
//         imagePath = pickedFile.path;
//       });
//     }
//   }
// }

// Future<void> pickImageFromCamera() async {
//   final pickedFile = await picker.getImage(source: ImageSource.camera);

//   if (pickedFile != null) {
//     File imageFile = File(pickedFile.path);
//     int fileSizeInBytes = imageFile.lengthSync();

//     if (fileSizeInBytes > 1048576) {
//       // Jika ukuran file lebih besar dari 1 MB, tampilkan alert
//       _showFileSizeAlert();
//     } else {
//       setState(() {
//         imagePath = pickedFile.path;
//       });
//     }
//   }
// }

// void _showFileSizeAlert() {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('File Size Exceeded'),
//         content: Text('Ukuran file gambar tidak boleh lebih dari 1 MB.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('OK'),
//           ),
//         ],
//       );
//     },
//   );
// }

//   Future<void> uploadData() async {
//     try {
//       // Panggil service upload
//       final response = await UploadService().uploadData(
//         description: _deskripsiController.text,
//         photoPath: imagePath,
//         jwtToken: _token!
//       );

//       if (response['error'] == false) {
//         // Sukses menambahkan data
//         print('Success: ${response['message']}');
//       } else {
//         // Gagal menambahkan data
//         print('Error: ${response['message']}');
//       }
//     } catch (error) {
//       print('Error: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(253, 4, 148, 192),
//         elevation: 0,
//         title: Text('Add'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Get.toNamed(RouteName.homeScreen);
//           },
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 _showImageSourceDialog();
//               },
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   border: Border.all(color: Colors.black, width: 2),
//                 ),
//                 child: imagePath.isNotEmpty
//                     ? Image.file(
//                         File(imagePath),
//                         height: 200,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       )
//                     : Center(
//                         child: Text(
//                           'Tap to select image',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: _deskripsiController,
//               decoration: InputDecoration(
//                 labelText: 'Deskripsi',
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 uploadData();
//               },
//               child: Text('Unggah'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _showImageSourceDialog() async {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Pilih Sumber Gambar'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 pickImageFromGallery();
//               },
//               child: Text('Galeri'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 pickImageFromCamera();
//               },
//               child: Text('Kamera'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/view_models/controllers/addViewModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahPage extends StatefulWidget {
  @override
  State<TambahPage> createState() => _TambahPageState();
}

class _TambahPageState extends State<TambahPage> {
  final AddDataController _controller = Get.put(AddDataController());
  final TextEditingController _title = TextEditingController();
  final TextEditingController _details = TextEditingController();
  File? _image;
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

  void _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getTokenFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _token = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Upload Story'),
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
                  // _image != null
                  //     ? Image.file(_image!)
                  //     : ElevatedButton(
                  //         onPressed: _selectImage,
                  //         child: Text('Select Image'),
                  //       ),
                  TextFormField(
                    controller: _details,
                    decoration: InputDecoration(labelText: 'Details'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_title.text.isNotEmpty && _details.text.isNotEmpty) {
                        _controller.uploadStory(
                            _token!, _title.text, _details.text);
                      } else {
                        Get.snackbar('Error',
                            'Please select an image and provide description');
                      }
                    },
                    child: Text('Upload Story'),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Upload Story'),
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
