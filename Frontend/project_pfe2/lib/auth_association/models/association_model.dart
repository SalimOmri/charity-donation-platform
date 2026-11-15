class AssociationModel {
  final int id;
  final String name;
  final String phoneNumber;
  final String email;
  final String statue;
  final String password;

  AssociationModel({
    required this.id,
    required this.statue,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  // Named constructor for an empty UserModel
  static AssociationModel empty() => AssociationModel(
        id: 0,
        name: '',
        phoneNumber: '',
        email: '',
        statue: '',
        password: '',
      );

  // Convert object to JSON (for sending to backend)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'statue': statue,
      'password': password,
    };
  }

  factory AssociationModel.fromJson(Map<String, dynamic> json) {
    return AssociationModel(
      id: json['id'],
      name: json['name'],
      statue: json['statue'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'] ?? '',
    );
  }
}
