import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_pfe2/auth_user/models/register_request.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controller = Get.put(AuthController());

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  String selectedGender = 'Male';
  DateTime? selectedDate;
  RxBool obscurePassword = true.obs;

  final Color mainColor = const Color(0xFF008000); // اللون الرئيسي

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
        toolbarHeight: 75,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: firstnameController,
                      decoration: InputDecoration(
                        labelText: "First Name",
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person, color: mainColor),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: lastnameController,
                      decoration: InputDecoration(
                        labelText: "Last Name",
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_outline, color: mainColor),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone, color: mainColor),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedGender,
                      items: ['Male', 'Female'].map((gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Gender",
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(Icons.wc, color: mainColor),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: dateOfBirthController,
                      decoration: InputDecoration(
                        labelText: "Date of Birth",
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today, color: mainColor),
                      ),
                      readOnly: true,
                      onTap: () => _selectDate(context),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email, color: mainColor),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    Obx(() => TextField(
                          controller: passwordController,
                          obscureText: obscurePassword.value,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: const OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock, color: mainColor),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: mainColor,
                              ),
                              onPressed: () {
                                obscurePassword.value =
                                    !obscurePassword.value;
                              },
                            ),
                          ),
                        )),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          RegisterRequest registerRequest = RegisterRequest(
                            id: 0,
                            firstname: firstnameController.text,
                            lastname: lastnameController.text,
                            email: emailController.text,
                            gender: selectedGender,
                            dateOfBirth: dateOfBirthController.text,
                            password: passwordController.text,
                            phoneNumber: phoneController.text,
                          );
                          controller.register(registerRequest);
                        },
                        child: const Text("Register",
                            style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.offNamed("/login"),
                      style: TextButton.styleFrom(
                        foregroundColor: mainColor,
                      ),
                      child: const Text("Already have an account? Login"),
                    )
                  ],
                ),
              ),
            )),
    );
  }
}
