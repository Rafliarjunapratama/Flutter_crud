import 'package:apiucup/controler/controler.dart';
import 'package:apiucup/list/list.dart';
import 'package:apiucup/models/admin.dart';
import 'package:apiucup/screens/admin/add_admin.dart';
import 'package:apiucup/screens/admin/edit_admin.dart';
import 'package:flutter/material.dart';

class AdminList extends StatefulWidget {
  final String idname;
  AdminList(this.idname);

  @override
  State<AdminList> createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
  final Respository repository =
      Respository(); // Assuming Respository is a typo for Repository
  late Future<List<Admin>> motivasi; // Use 'late' to defer initialization
  int currentIndex = 1;
  String? name;

  @override
  void initState() {
    super.initState();
    motivasi = repository.fetchAdmins(); // Initialize motivasi
    _fetchData();
  }

  void _fetchData() async {
    await repository.countData();
    await repository.countmotivasi();
    try {
      final data = await repository.getDataById(widget.idname);
      setState(() {
        name = data['name']; // Assign name from API
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
              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => add_admin(widget.idname),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.person_add_alt_1_outlined,
                  color: Colors.white,
                ),
                label: const Text('Add Motivasi'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  backgroundColor: Colors.blue,
                ),
              ),
              SizedBox(
                height: 10,
              ),

              FutureBuilder<List<Admin>>(
                future: motivasi, // Ensure this matches the type
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Admin found.'));
                  } else {
                    var AdminList = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: AdminList.length,
                      itemBuilder: (context, index) {
                        var Admin = AdminList[index];
                        return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Flexible untuk menangani teks panjang
                                Flexible(
                                  flex: 3,
                                  child: ListTile(
                                    title: Text(Admin.name),
                                    subtitle: Text(Admin.email),
                                  ),
                                ),

                                // Tombol edit
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            edit_admin(widget.idname, Admin.id),
                                      ),
                                    );
                                    print('Edit button pressed');
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  label: Text('Edit'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.white.withOpacity(0.9),
                                    foregroundColor: Colors.black,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 6.0),
                                  ),
                                ),

                                SizedBox(width: 8.0), // Spasi antar tombol

                                // Tombol hapus
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    bool response =
                                        await repository.delete(Admin.id);
                                    if (response) {
                                      await loadData(); // Reload data after deletion
                                    }
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  label: Text('Delete'),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 6.0),
                                  ),
                                ),
                              ],
                            ));
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(widget.idname, currentIndex));
  }

  Future<void> loadData() async {
    setState(() {
      motivasi = repository.fetchAdmins(); // Reload motivasi data
    });
  }
}
