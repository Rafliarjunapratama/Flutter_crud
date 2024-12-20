import 'package:apiucup/models/motivasi.dart';
import 'package:apiucup/screens/admin_list.dart';
import 'package:apiucup/screens/dashboard_admin.dart';
import 'package:apiucup/screens/login.dart';
import 'package:apiucup/screens/motivasi.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final String idname;

  BottomNavBar(this.idname, this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex, // Directly access currentIndex
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: true,
      onTap: (index) {
        // Navigate to different pages based on the index
        switch (index) {
          case 0:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Stack(
                    children: [
                      Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            image: const DecorationImage(
                              image: AssetImage("assets/girl3.gif"),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 60, // Jarak dari atas
                                left: -40, // Jarak dari kiri
                                child: Container(
                                  width: 300,
                                  height: 300,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/loading.gif"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                );
              },
            );
            Future.delayed(Duration(seconds: 5));
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(idname), // Pass idname here
              ),
            );
            break;
          case 1:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Stack(
                    children: [
                      Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            image: const DecorationImage(
                              image: AssetImage("assets/girl3.gif"),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 60, // Jarak dari atas
                                left: -40, // Jarak dari kiri
                                child: Container(
                                  width: 300,
                                  height: 300,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/loading.gif"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                );
              },
            );
            Future.delayed(Duration(seconds: 5));
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminList(idname),
              ),
            );
            break;
          case 2:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Stack(
                    children: [
                      Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            image: const DecorationImage(
                              image: AssetImage("assets/girl3.gif"),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 60, // Jarak dari atas
                                left: -40, // Jarak dari kiri
                                child: Container(
                                  width: 300,
                                  height: 300,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/loading.gif"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                );
              },
            );
            Future.delayed(Duration(seconds: 5));
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MotivasiList(idname),
              ),
            );
            break;
          case 3:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Stack(
                    children: [
                      Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            image: const DecorationImage(
                              image: AssetImage("assets/girl3.gif"),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 60, // Jarak dari atas
                                left: -40, // Jarak dari kiri
                                child: Container(
                                  width: 300,
                                  height: 300,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/loading.gif"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                );
              },
            );
            Future.delayed(Duration(seconds: 5));
            Navigator.of(context).pop();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
              (route) => false, // Hapus semua stack halaman sebelumnya
            );

            break;
          default:
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_2), label: "Admin List"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_2_sharp), label: "Motivasi"),
        BottomNavigationBarItem(
            icon: Icon(Icons.logout_outlined), label: "Settings"),
      ],
    );
  }
}
