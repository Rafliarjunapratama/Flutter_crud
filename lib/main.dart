import 'package:apiucup/screens/admin_list.dart';
import 'package:apiucup/screens/dashboard_admin.dart';
import 'package:apiucup/screens/login.dart';
import 'package:apiucup/screens/motivasi.dart';
import 'package:apiucup/screens/motivasi/add_motivasi.dart';
import 'package:apiucup/screens/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}
