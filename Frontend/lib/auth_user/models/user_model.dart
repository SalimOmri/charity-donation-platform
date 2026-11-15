class UserModel {
  final int id;
  final String firstname;
  final String lastname;
  final String phoneNumber;
  final String email;
  final String password;
  final String dateOfBirth;
  final String gender;
  final String role;

  UserModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.gender,
    required this.role,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  // Named constructor for an empty UserModel
  static UserModel empty() => UserModel(
        id: 0,
        firstname: '',
        lastname: '',
        dateOfBirth: '',
        gender: '',
        role: '',
        phoneNumber: '',
        email: '',
        password: '',
      );

  // Convert object to JSON (for sending to backend)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
    };
  }

  // Optional: Create object from JSON (if needed)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      role: json['authorities'][0]['authority'],
      dateOfBirth: json['dateOfBirth'] ?? '',
      gender: json['gender'] ?? '',
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'] ?? '',
    );
  }
}
