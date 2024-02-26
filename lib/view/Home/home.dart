import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:getx/data/response/status.dart';
import 'package:getx/models/userModel.dart';
import 'package:getx/res/routes/routes_name.dart';
import 'package:getx/view/Detail/detail.dart';
import 'package:getx/view/Tambah/tambah.dart';
import 'package:getx/view_models/controllers/deleteController.dart';
import 'package:getx/view_models/controllers/homeViewModel.dart';
import 'package:getx/view_models/controllers/userPreference.dart';
import 'package:getx/view_models/services/homeService.dart';
import 'package:getx/view_models/services/loginService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<String?> _getTokenFuture;
  final homeController = Get.put(HomeController());
  UserPreference userPreference = UserPreference();
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

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    // Redirect user to login page after successful logout
    Get.offAllNamed('/login'); // or Get.offAllNamed('/'); to go to home page
  }

  @override
  Widget build(BuildContext context) {
    return

        // body: RefreshIndicator(
        //   onRefresh: _refreshData,
        //   child: ListView.builder(
        //     itemCount: _data.length,
        //     itemBuilder: (context, index) {
        //       return CardWidget(
        //         imageUrl: _data[index]['photoUrl'],
        //         name: _data[index]['name'],
        //         description: _data[index]['description'],
        //         jwtToken: widget.user.token,
        //         storyId: _data[index]['id'],
        //       );
        //     },
        //   ),
        // ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: Icon(Icons.add),
        //   backgroundColor: Color.fromARGB(253, 4, 148, 192),
        // ),
        FutureBuilder<String?>(
      future: _getTokenFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _token = snapshot.data;
          if (_token != null) {
            homeController.getAllApi(_token!);
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(253, 4, 148, 192),
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text('Story App'),
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: _logout,
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                homeController.getAllApi(_token!);
              },
              child: Obx(() {
                switch (homeController.rxRequestStatus.value) {
                  case Status.LOADING:
                    return Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Text("Ada error");
                  case Status.COMPLETED:
                    return ListView.builder(
                      itemCount: homeController
                          .getAll.length, // Menggunakan panjang RxList
                      itemBuilder: (context, index) {
                        final data = homeController.getAll[
                            index]; // Mengambil data pada indeks tertentu
                        return CardWidget(
                          imageUrl: '', // Mengakses properti dari data
                          name: data.title.toString(),
                          description: data.details.toString(),
                          jwtToken:
                              _token!, // Pastikan token sudah diinisialisasi
                          storyId: data.id.toString(),
                        );
                      },
                    );
                  default:
                    return SizedBox.shrink();
                }
              }),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.toNamed(RouteName.tambahScreen);
              },
              child: Icon(Icons.add),
              backgroundColor: Color.fromARGB(253, 4, 148, 192),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class CardWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final String jwtToken;
  final String storyId;
  final _deleteController = Get.put(DeleteController());

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
        Get.toNamed(RouteName.detailScreen, arguments: storyId);
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(
              'https://via.placeholder.com/200',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          child: Text('Update'),
                          value: 'update',
                        ),
                        PopupMenuItem(
                          child: Text('Delete'),
                          value: 'delete',
                        ),
                      ];
                    },
                    onSelected: (String value) async {
                      if (value == 'update') {
                        Get.toNamed(RouteName.updateScreen, arguments: storyId);
                      } else if (value == 'delete') {
                        await _deleteController.deleteTask(jwtToken, storyId);
                        print("ini edit story id $storyId");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
