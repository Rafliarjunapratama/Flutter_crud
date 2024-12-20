import 'package:apiucup/controler/controler.dart';
import 'package:apiucup/list/list.dart';
import 'package:apiucup/models/admin.dart';
import 'package:apiucup/screens/admin_list.dart';
import 'package:apiucup/screens/motivasi.dart';
import 'package:flutter/material.dart';

class edit_admin extends StatefulWidget {
  final String idname;
  final String? idpick;
  edit_admin(this.idname, this.idpick);

  @override
  State<edit_admin> createState() => _edit_adminState();
}

class _edit_adminState extends State<edit_admin> {
  String? isian;
  String? name;
  String? nameuser;
  int currentIndex = 0;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final Respository repository = Respository();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    try {
      final data = await repository.getDataById(widget.idname);
      setState(() {
        name = data['name'].toString(); // Convert to String
      });
    } catch (e) {
      print('Error: $e');
    }

    try {
      final apik = await repository.getadmin(widget.idpick);
      setState(() {
        _name.text = apik['name'].toString(); // Convert to String
        _email.text = apik["email"].toString();
        _password.text = apik["password"].toString();
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
            padding: EdgeInsets.all(16.0),
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
                        "ADMIN LIST",
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
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Tambah Motivasi ",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Text(
                "isi admin",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3), // Background transparan
                  borderRadius: BorderRadius.circular(20), // Border radius
                ),
                child: TextField(
                  controller: _name,
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
                    hintText: 'isi admin',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Text(
                "isi email",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),

              Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3), // Background transparan
                  borderRadius: BorderRadius.circular(20), // Border radius
                ),
                child: TextField(
                  controller: _email,
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
                    hintText: 'isi email',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Text(
                "isi password",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),

              Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3), // Background transparan
                  borderRadius: BorderRadius.circular(20), // Border radius
                ),
                child: TextField(
                  controller: _password,
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
                    hintText: 'isi password',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              ElevatedButton(
                onPressed: () async {
                  // Tampilkan full-screen loading screen
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

                  bool response = await repository.editadmin(
                      _name.text, _email.text, _password.text, widget.idpick);

                  Navigator.of(context).pop();

                  if (response) {
                    // Navigasi ke halaman login
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminList(widget.idname),
                      ),
                    );
                  } else {
                    // Tampilkan notifikasi gagal
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gagal menambahkan admin!')),
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
                    'Tamah Motivasi',
                    style: TextStyle(color: Colors.black), // Warna teks
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(widget.idname, currentIndex));
  }
}
