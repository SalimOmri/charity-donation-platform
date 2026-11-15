import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pfe2/auth_association/models/register_association_request.dart';
import '../controllers/auth_association_controller.dart';

class RegisterAssociationScreen extends StatefulWidget {
  const RegisterAssociationScreen({super.key});

  @override
  State<RegisterAssociationScreen> createState() => _RegisterAssociationScreenState();
}

class _RegisterAssociationScreenState extends State<RegisterAssociationScreen> {
  final controller = Get.put(AuthAssociationController());

  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final Color mainColor = const Color(0xFF008000); // اللون الرئيسي

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Association"),
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
                    buildTextField(nameController, "Name", Icons.account_circle),
                    const SizedBox(height: 16),
                    buildTextField(phoneController, "Phone Number", Icons.phone,
                        keyboardType: TextInputType.phone),
                    const SizedBox(height: 16),
                    buildTextField(emailController, "Email", Icons.email,
                        keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 16),
                    buildTextField(passwordController, "Password", Icons.lock,
                        obscure: true),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          RegisterAssociationRequest registerRequest =
                              RegisterAssociationRequest(
                            id: 0,
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phoneNumber: phoneController.text,
                            statue: 'en attente',
                          );
                          controller.register(registerRequest);
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.offNamed("/loginAssociation"),
                      style: TextButton.styleFrom(foregroundColor: mainColor),
                      child: const Text("Already have an account? Login"),
                    ),
                  ],
                ),
              ),
            )),
    );
  }

  Widget buildTextField(TextEditingController controller, String label, IconData icon,
      {bool obscure = false, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon, color: mainColor),
      ),
    );
  }
}
