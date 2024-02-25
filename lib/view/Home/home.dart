import 'package:dio/dio.dart';
import 'package:getx/models/userModel.dart';
import 'package:getx/view/Detail/detail.dart';
import 'package:getx/view/Tambah/tambah.dart';
import 'package:getx/view_models/services/homeService.dart';
import 'package:getx/view_models/services/loginService.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  final UserModel user;
  HomeView({required this.user});
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<dynamic> _data = [];
  late HomeService homeService;

  @override
  void initState() {
    super.initState();
    homeService = HomeService(Dio());
    init();
  }

  Future<void> init() async {
    try {
      List<dynamic> data = await homeService.fetchData(widget.user.token);
      setState(() {
        _data = data;
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _refreshData() async {
    try {
      List<dynamic> data = await homeService.fetchData(widget.user.token);
      setState(() {
        _data = data;
      });
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
        title: Text('Story App'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final logoutValue = await LoginService().logout();
              if (logoutValue == true) {
                Navigator.of(context).pushReplacementNamed('/login');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text(
                      'error with your token, have to login again',
                    ),
                  ),
                );
                Navigator.of(context).pushReplacementNamed('/login');
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context, index) {
            return CardWidget(
              imageUrl: _data[index]['photoUrl'],
              name: _data[index]['name'],
              description: _data[index]['description'],
              jwtToken: widget.user.token,
              storyId: _data[index]['id'],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahPage(jwtToken: widget.user.token),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(253, 4, 148, 192),
      ),
    );
  }
}


class CardWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final String jwtToken;
  final String storyId;

  CardWidget({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.jwtToken,
    required this.storyId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              jwtToken: jwtToken,
              storyId: storyId,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
