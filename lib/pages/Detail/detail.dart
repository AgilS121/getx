import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:getx/services/detailService.dart';

class DetailPage extends StatefulWidget {
  final String jwtToken;
  final String storyId;

  DetailPage({required this.jwtToken, required this.storyId});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Map<String, dynamic> _storyDetail;
  late DetailService detailService;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    detailService = DetailService(Dio());
    init();
  }

  Future<void> init() async {
    try {
      Map<String, dynamic> storyDetail =
          await detailService.fetchStoryById(widget.jwtToken, widget.storyId);
      setState(() {
        _storyDetail = storyDetail;
        _isLoading = false;
      });
    } catch (error) {
      print('Error: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Story Detail'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    _storyDetail['photoUrl'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  Text(
                    _storyDetail['name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _storyDetail['description'],
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Created At: ${_storyDetail['createdAt']}',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Location: ${_storyDetail['lat']}, ${_storyDetail['lon']}',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
    );
  }
}
