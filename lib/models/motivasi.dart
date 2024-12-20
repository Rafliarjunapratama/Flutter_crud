class Motivasi {
  final String id; // Ensure the ID is an String?
  final String isi;
  final String namauser;

  Motivasi({required this.id, required this.isi, required this.namauser});

  factory Motivasi.fromJson(Map<String, dynamic> json) {
    return Motivasi(
      id: json['id'], // Ensure it's parsed as an String?
      isi: json['isi'],
      namauser: json['namauser'],
    );
  }
}
