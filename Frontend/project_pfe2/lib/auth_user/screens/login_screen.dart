import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(AuthController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool obscurePassword = true.obs;

  final Color mainColor = const Color(0xFF008000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
        title: const Text("Login"),
        toolbarHeight: 75,
      ),
      backgroundColor: const Color(0xFFF5F5F5), // خلفية خفيفة
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                       Image.asset("assets/logos/Mobile login-rafiki.png",  height: 270, width: 270),
                      const SizedBox(height: 12),
                      const Text(
                        "Welcome Back!",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 40),
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
                              prefixIcon: Icon(Icons.lock_outline, color: mainColor),
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            controller.login(emailController.text, passwordController.text);
                          },
                          child: const Text("Login", style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.toNamed("/register"),
                        style: TextButton.styleFrom(
                          foregroundColor: mainColor,
                        ),
                        child: const Text("No account? Register"),
                      )
                    ],
                  ),
                ),
              ),
            )),
    );
  }
}
