import 'package:flutter/material.dart';
import 'package:apiucup/controler/controler.dart';
import 'package:apiucup/list/list.dart';
import '../models/admin.dart';
import '../controler/controler.dart';
import '../list/list.dart'; // Jika Anda memiliki halaman lain seperti ini

class Dashboard extends StatefulWidget {
  final String idname;
  Dashboard(this.idname);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Respository repository = Respository();
  String? name;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    // Logic to preload data if needed.
    await repository.countData();
    await repository.countmotivasi();
    try {
      final data = await repository.getDataById(widget.idname);
      setState(() {
        name = data['name']; // Ambil nilai 'name' dari data API
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/ai.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.all(16.0), // Tambahkan padding opsional
            children: [
              // Bagian header dan profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "WELCOME BACK",
                        style: TextStyle(
                          fontSize: 20,
                          height: 1.0,
                          color: Color(0xff4a4747),
                          fontFamily: "logisu",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$name",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          height: 1.0,
                          fontFamily: "logisu",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/girl2.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(
                        color: Color(0x46ffffff),
                        width: 2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Bagian kartu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Color(0x65d0a02f),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\n Admin \n",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff3a3838),
                            fontWeight: FontWeight.bold,
                            fontFamily: "loginsu",
                          ),
                        ),
                        FutureBuilder<int>(
                          future: repository.countmotivasi(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                "${snapshot.data}",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Color(0xff3a3838),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "loginsu",
                                ),
                              );
                            } else {
                              return Text(
                                "..",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Color(0xff3a3838),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "loginsu",
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Color(0x91a643d3),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\n Motivasi \n",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff3a3838),
                            fontWeight: FontWeight.bold,
                            fontFamily: "loginsu",
                          ),
                        ),
                        FutureBuilder<int>(
                          future: repository.countData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                "${snapshot.data}",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Color(0xff3a3838),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "loginsu",
                                ),
                              );
                            } else {
                              return Text(
                                "..",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Color(0xff3a3838),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "loginsu",
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(widget.idname, currentIndex));
  }
}
