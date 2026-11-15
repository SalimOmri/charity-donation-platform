class RegisterAssociationRequest {
  final int id;
  final String name;
  final String phoneNumber;
  final String email;
  final String password;
  final String statue;

  RegisterAssociationRequest({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.statue,
  });

  // Convert object to JSON (for sending to backend)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
       'statue': statue
    };
  }

  // Optional: Create object from JSON (if needed)
  factory RegisterAssociationRequest.fromJson(Map<String, dynamic> json) {
    return RegisterAssociationRequest(
      id: json['id'],
      name: json['name'],
      statue: json['statue'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'],
    );
  }
}
