import 'dart:html';
import 'dart:io';
import 'dart:ui_web';

import 'package:apiucup/controler/controler.dart';
import 'package:apiucup/screens/dashboard_admin.dart';
import 'package:apiucup/screens/motivasi/add_motivasi.dart';
import 'package:apiucup/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Respository respository = Respository();
  final TextEditingController _user = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage("assets/girl2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 250,
              ),
              Text(
                "Login Admin",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: "logisu",
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
              SizedBox(
                height: 15,
              ),

              // Input Username
              Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3), // Background transparan
                  borderRadius: BorderRadius.circular(20), // Border radius
                ),
                child: TextField(
                  controller: _user,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2), // Border putih saat fokus
                    ),
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),

              const SizedBox(height: 20),
              // Input Password
              Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3), // Background transparan
                  borderRadius: BorderRadius.circular(20), // Border radius
                ),
                child: TextField(
                  controller: _password,
                  obscureText: true, // Untuk menyembunyikan teks password
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 30),
              // Tombol Login
              ElevatedButton(
                onPressed: () async {
                  if (_user.text.isEmpty || _password.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Error"),
                        content: Text("Email dan password tidak boleh kosong."),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("OK"),
                          ),
                        ],
                      ),
                    );
                    return;
                  }

                  // Tampilkan loading dialog
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
                                            image: AssetImage(
                                                "assets/loading.gif"),
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
                  await Future.delayed(Duration(seconds: 5));
                  // Panggil API untuk login
                  String? id =
                      await respository.LoginAdmin(_user.text, _password.text);

                  // Hilangkan loading dialog
                  Navigator.of(context).pop();

                  if (id != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard(id)),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Login gagal. Periksa kembali data Anda!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.white.withOpacity(0.5), // Warna background tombol
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Radius untuk border tombol
                    side: const BorderSide(
                      color: Colors.white, // Warna border putih
                      width: 2, // Ketebalan border
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black), // Warna teks
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "do you not have account?",
                    style: TextStyle(
                      color: Color(0xb3ffffff),
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
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
                                                image: AssetImage(
                                                    "assets/loading.gif"),
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
                      await Future.delayed(Duration(seconds: 5));
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: Text(
                      " Register now!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
