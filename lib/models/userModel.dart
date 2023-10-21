class UserModel {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String? type;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': name,
      'email': email,
      'telefone': phone,
      'senha': password,
      'tipo': type,
    };
  }

  factory UserModel.fromMap(map) {
    return UserModel(
      name: map["nome"],
      email: map["email"],
      phone: map["telefone"],
      type: map['tipo'],
      password: map['senha'],
    );
  }
}
