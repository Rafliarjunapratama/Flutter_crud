import 'dart:convert';
import 'package:apiucup/models/motivasi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/admin.dart';

class Respository {
  String urlapi = "https://6560f04883aba11d99d1b9bd.mockapi.io/admin";

  Future<bool> addAdmin(String user, String email, String password) async {
    try {
      final respon = await http.post(
        Uri.parse(urlapi),
        body: jsonEncode({
          "name": user,
          "email": email,
          "password": password,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (respon.statusCode == 201) {
        return true; // Return true jika berhasil
      } else {
        print('Error: ${respon.body}'); // Untuk debugging
        return false; // Return false jika gagal
      }
    } catch (e) {
      print('Exception: $e'); // Untuk debugging error
      return false; // Return false jika ada exception
    }
  }

  Future<String?> LoginAdmin(String email, String password) async {
    try {
      final response = await http.get(Uri.parse(urlapi));
      print('HTTP Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List) {
          for (var item in data) {
            if (item['email'] == email && item['password'] == password) {
              // Return ID jika cocok
              return item['id'].toString();
            }
          }
        } else if (data is Map &&
            data.containsKey('email') &&
            data.containsKey('password')) {
          if (data['email'] == email && data['password'] == password) {
            // Return ID jika cocok
            return data['id'].toString();
          }
        } else {
          print('Invalid response structure');
        }
      } else {
        print('Login failed: HTTP error');
      }
      return null; // Jika tidak ada kecocokan atau error
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<List<Admin>> fetchAdmins() async {
    final response = await http.get(Uri.parse(urlapi));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Admin.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load admins');
    }
  }

  Future<bool> delete(String? id) async {
    try {
      final response = await http.delete(Uri.parse("$urlapi/$id"));

      if (response.statusCode == 200) {
        // Berhasil menghapus data
        return true;
      } else {
        // Gagal menghapus data
        return false;
      }
    } catch (e) {
      // Menangani error saat permintaan HTTP
      print("Error: $e");
      return false;
    }
  }

  Future<int> countData() async {
    try {
      final response = await http.get(Uri.parse(urlapi));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.length; // Return the count of items.
      } else {
        throw Exception(
            "Failed to load data with status code ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      return 0; // Return 0 in case of an error.
    }
  }

  Future<int> countmotivasi() async {
    try {
      final response = await http
          .get(Uri.parse("https://6560f04883aba11d99d1b9bd.mockapi.io/person"));
      if (response.statusCode == 200) {
        List<dynamic> data1 = json.decode(response.body);
        return data1.length; // Return the count of items.
      } else {
        throw Exception(
            "Failed to load data with status code ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      return 0; // Return 0 in case of an error.
    }
  }

  // Method untuk mengambil data berdasarkan ID
  Future<Map<String, dynamic>> getDataById(String id) async {
    final url = Uri.parse("$urlapi/$id");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Motivasi>> fetchMotivasi() async {
    final response = await http
        .get(Uri.parse("https://6560f04883aba11d99d1b9bd.mockapi.io/person"));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Motivasi.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load Motivasi");
    }
  }

  Future<bool> deleteMotivasi(String id) async {
    final response = await http.delete(
        Uri.parse("https://6560f04883aba11d99d1b9bd.mockapi.io/person/$id"));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addMotivasi(String isi, String namauser) async {
    try {
      final respon = await http.post(
        Uri.parse("https://6560f04883aba11d99d1b9bd.mockapi.io/person/"),
        body: jsonEncode({
          "isi": isi,
          "namauser": namauser,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (respon.statusCode == 201) {
        return true; // Return true jika berhasil
      } else {
        print('Error: ${respon.body}'); // Untuk debugging
        return false; // Return false jika gagal
      }
    } catch (e) {
      print('Exception: $e'); // Untuk debugging error
      return false; // Return false jika ada exception
    }
  }

  Future<Map<String, dynamic>> getmotivasti(String id) async {
    final url =
        Uri.parse("https://6560f04883aba11d99d1b9bd.mockapi.io/person/$id");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> editmotivasi(String isi, String nameUser, String? idName) async {
    try {
      // Endpoint URL
      final String url =
          "https://6560f04883aba11d99d1b9bd.mockapi.io/person/$idName";

      // Membuat data body untuk PUT request
      final Map<String, dynamic> body = {
        "isi": isi,
        "namauser": nameUser,
      };

      // Mengirim PUT request
      final http.Response response = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      // Mengecek status code untuk keberhasilan
      if (response.statusCode == 200) {
        return true; // Berhasil
      } else {
        print("Error: ${response.statusCode} - ${response.body} ${idName}");
        return false; // Gagal
      }
    } catch (e) {
      print("Exception: $e");
      return false; // Gagal
    }
  }

  Future<Map<String, dynamic>> getadmin(String? id) async {
    final url = Uri.parse("$urlapi/$id");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> editadmin(
      String isi, String nameUser, String password, String? idName) async {
    try {
      // Endpoint URL
      final String url = "$urlapi/$idName";

      // Membuat data body untuk PUT request
      final Map<String, dynamic> body = {
        "name": isi,
        "email": nameUser,
        "passowrd": password,
      };

      // Mengirim PUT request
      final http.Response response = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      // Mengecek status code untuk keberhasilan
      if (response.statusCode == 200) {
        return true; // Berhasil
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return false; // Gagal
      }
    } catch (e) {
      print("Exception: $e");
      return false; // Gagal
    }
  }
}
