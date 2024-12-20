class Admin {
  final String? id; // Diubah dari int ke String
  final String name;
  final String email;
  final String password;

  Admin({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'], // Tetap sebagai String
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
