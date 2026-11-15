import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pfe2/auth_user/controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    final user = controller.userModel.value;
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${user.firstname} ${user.lastname}"),
        backgroundColor: Color(0xFF008000), // لون متناسق مع التصميم العام
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Get.offAllNamed("/login");
            },
            icon: Icon(Icons.logout, color: Colors.white),
            tooltip: 'Log out', // إضافة Tooltip لتوضيح وظيفة الزر
          ),
        ],
        toolbarHeight: 75,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // رسالة ترحيب مع صورة صغيرة
              CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFF008000),
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Welcome back, ${user.firstname}!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              // زر التبرع
              ElevatedButton(
                onPressed: () {
                  Get.toNamed("/donate");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF008000), // لون الزر
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Text(
                    "Make a Donation",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // إضافة رسالة تشجيعية أو نص إضافي
              Text(
                "Your support makes a big difference!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
