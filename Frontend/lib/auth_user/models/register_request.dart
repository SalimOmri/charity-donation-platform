class RegisterRequest {
  final int id;
  final String firstname;
  final String lastname;
  final String phoneNumber;
  final String email;
  final String password;
  final String dateOfBirth;
  final String gender;

  RegisterRequest({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  // Convert object to JSON (for sending to backend)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'dateOfBearth': dateOfBirth,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
    };
  }

  // Optional: Create object from JSON (if needed)
  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      dateOfBirth: json['dateOfBearth'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'],
    );
  }
}
