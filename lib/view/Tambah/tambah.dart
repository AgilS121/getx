import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getx/view_models/services/uploadService.dart';
import 'package:image_picker/image_picker.dart';

class TambahPage extends StatefulWidget {
  final String jwtToken;
  TambahPage({required this.jwtToken});

  @override
  _TambahPageState createState() => _TambahPageState();
}


class _TambahPageState extends State<TambahPage> {
  final TextEditingController _deskripsiController = TextEditingController();
  final picker = ImagePicker();
  String imagePath = '';

 Future<void> pickImageFromGallery() async {
  final pickedFile = await picker.getImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    int fileSizeInBytes = imageFile.lengthSync();

    if (fileSizeInBytes > 1048576) {
      // Jika ukuran file lebih besar dari 1 MB, tampilkan alert
      _showFileSizeAlert();
    } else {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }
}

Future<void> pickImageFromCamera() async {
  final pickedFile = await picker.getImage(source: ImageSource.camera);

  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    int fileSizeInBytes = imageFile.lengthSync();

    if (fileSizeInBytes > 1048576) {
      // Jika ukuran file lebih besar dari 1 MB, tampilkan alert
      _showFileSizeAlert();
    } else {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }
}

void _showFileSizeAlert() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('File Size Exceeded'),
        content: Text('Ukuran file gambar tidak boleh lebih dari 1 MB.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}


  Future<void> uploadData() async {
    try {
      // Panggil service upload
      final response = await UploadService().uploadData(
        description: _deskripsiController.text,
        photoPath: imagePath,
        jwtToken: widget.jwtToken
      );

      if (response['error'] == false) {
        // Sukses menambahkan data
        print('Success: ${response['message']}');
      } else {
        // Gagal menambahkan data
        print('Error: ${response['message']}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(253, 4, 148, 192),
        elevation: 0,
        title: Text('Add'),
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _showImageSourceDialog();
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: imagePath.isNotEmpty
                    ? Image.file(
                        File(imagePath),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Text(
                          'Tap to select image',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _deskripsiController,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                uploadData();
              },
              child: Text('Unggah'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showImageSourceDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih Sumber Gambar'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                pickImageFromGallery();
              },
              child: Text('Galeri'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                pickImageFromCamera();
              },
              child: Text('Kamera'),
            ),
          ],
        );
      },
    );
  }
}
