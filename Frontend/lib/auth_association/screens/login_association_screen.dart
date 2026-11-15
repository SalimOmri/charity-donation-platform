// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_association_controller.dart';

class LoginAssociationScreen extends StatefulWidget {
  const LoginAssociationScreen({super.key});

  @override
  LoginAssociationScreenState createState() => LoginAssociationScreenState();
}

class LoginAssociationScreenState extends State<LoginAssociationScreen> {
  final controller = Get.put(AuthAssociationController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool obscurePassword = true.obs;

  final Color mainColor = const Color(0xFF008000); // اللون الرئيسي

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Association"),
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
        toolbarHeight: 75,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logos/Mobile login-rafiki.png",
                      height: 300,
                      width: 300,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email, color: mainColor),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(() => TextField(
                          controller: passwordController,
                          obscureText: obscurePassword.value,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock, color: mainColor),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: mainColor,
                              ),
                              onPressed: () {
                                obscurePassword.value = !obscurePassword.value;
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
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          controller.login(emailController.text, passwordController.text);
                        },
                        child: const Text("Login", style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed("/registerAssociation"),
                      style: TextButton.styleFrom(
                        foregroundColor: mainColor,
                      ),
                      child: const Text("No account? Register"),
                    )
                  ],
                ),
              ),
          )),
    );
  }
}
