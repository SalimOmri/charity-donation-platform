// lib/screens/initial_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 30),
                    // شعار وأسم التطبيق
                    const Icon(
                      Icons.volunteer_activism,
                      size: 80,
                      color: Color(0xFF2ECC71), // تغيرنا اللون هنا للون جديد
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Welcome to Charity App",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Helping made simple.\nChoose your role to begin.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    // زر المستخدم
                    SizedBox(
                      width: size.width * 0.9,
                      height: 60,
                      child: ElevatedButton.icon(
                        onPressed: () => Get.toNamed("/login"),
                        icon: const Icon(Icons.person, size: 24, color: Colors.white),
                        label: const Text("Continue as Donator",
                            style: TextStyle(fontSize: 18, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF008000), // تغيرنا اللون هنا أيضًا
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // زر الجمعية
                    SizedBox(
                      width: size.width * 0.9,
                      height: 60,
                      child: ElevatedButton.icon(
                        onPressed: () => Get.toNamed("/loginAssociation"),
                        icon: const Icon(Icons.group, size: 24, color: Colors.white),
                        label: const Text("Continue as Association",
                            style: TextStyle(fontSize: 18, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF008000), // تغيرنا اللون هنا
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 5,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "© 2025 CharityApp. All rights reserved.",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
