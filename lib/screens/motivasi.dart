import 'package:apiucup/controler/controler.dart';
import 'package:apiucup/list/list.dart';
import 'package:apiucup/screens/motivasi/add_motivasi.dart';
import 'package:apiucup/screens/motivasi/edit.dart';
import 'package:flutter/material.dart';
import '../models/motivasi.dart';

class MotivasiList extends StatefulWidget {
  final String idname;
  MotivasiList(this.idname);

  @override
  State<MotivasiList> createState() => _MotivasiListState();
}

class _MotivasiListState extends State<MotivasiList> {
  final Respository repository =
      Respository(); // Assuming Respository is a typo for Repository
  late Future<List<Motivasi>> motivasi; // Use 'late' to defer initialization
  int currentIndex = 2;
  String? name;

  @override
  void initState() {
    super.initState();
    motivasi = repository.fetchMotivasi(); // Initialize motivasi
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/ai.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            buildHeader(),
            const SizedBox(height: 10),
            oncom(),
            const SizedBox(height: 10),
            buildMotivasiList(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(widget.idname, currentIndex),
    );
  }

  Widget oncom() {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => add_motivasi(widget.idname)),
        );
      },
      icon: const Icon(
        Icons.person_add_alt_1_outlined,
        color: Colors.white,
      ),
      label: const Text('Add Motivasi'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "MOTIVASI LIST",
              style: TextStyle(
                fontSize: 20,
                height: 1.0,
                color: Color(0xff4a4747),
                fontFamily: "logisu",
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              name ?? '', // Safe null check for name
              style: const TextStyle(
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
            image: const DecorationImage(
              image: AssetImage("assets/girl2.jpg"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(35),
            border: Border.all(
              color: const Color(0x46ffffff),
              width: 2,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMotivasiList() {
    return FutureBuilder<List<Motivasi>>(
      future: motivasi,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Motivasi found.'));
        } else {
          var motivasiList = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: motivasiList.length,
            itemBuilder: (context, index) {
              var motivasi = motivasiList[index];
              return buildMotivasiItem(motivasi);
            },
          );
        }
      },
    );
  }

  Widget buildMotivasiItem(Motivasi motivasi) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 3,
            child: ListTile(
              title: Text(motivasi.isi),
              subtitle: Text(motivasi.namauser),
            ),
          ),
          buildEditButton(motivasi),
          const SizedBox(width: 8.0),
          buildDeleteButton(motivasi),
        ],
      ),
    );
  }

  ElevatedButton buildEditButton(Motivasi motivasi) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Edit_motivasi(widget.idname, motivasi.id)),
        );
      },
      icon: const Icon(
        Icons.edit,
        color: Colors.blue,
      ),
      label: const Text('Edit'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.9),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      ),
    );
  }

  ElevatedButton buildDeleteButton(Motivasi motivasi) {
    return ElevatedButton.icon(
      onPressed: () async {
        bool response = await repository.deleteMotivasi(motivasi.id);
        if (response) {
          await loadData(); // Reload data after deletion
        }
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      label: const Text('Delete'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      ),
    );
  }

  // Function to reload data
  Future<void> loadData() async {
    setState(() {
      motivasi = repository.fetchMotivasi(); // Reload motivasi data
    });
  }
}
