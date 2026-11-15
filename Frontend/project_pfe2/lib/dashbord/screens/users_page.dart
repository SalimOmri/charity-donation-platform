import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.users.isEmpty) {
          return const Center(child: Text("No users found."));
        }

        return ListView.separated(
  padding: const EdgeInsets.all(16),
  separatorBuilder: (_, __) => const SizedBox(height: 12), // مسافة بين العناصر
  itemCount: controller.users.length,
  itemBuilder: (context, index) {
    final user = controller.users[index];
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8), // إضافة مسافة بين العناصر
      decoration: BoxDecoration(
        color: Colors.green[100], // خلفية بيضاء
        borderRadius: BorderRadius.circular(12), // تقويس الزوايا
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200, 
            blurRadius: 8, 
            spreadRadius: 2, // الظل الخفيف
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF008000), // لون الخلفية الدائري
          child: Text(
            user.firstname[0].toUpperCase(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          "${user.firstname} ${user.lastname}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16, // زيادة حجم النص قليلاً
            color: Colors.black, // تحسين اللون ليكون واضحًا
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.email, color: Colors.grey, size: 18), // أيقونة البريد الإلكتروني
                const SizedBox(width: 8),
                Expanded( // هنا تم استخدام Expanded لتوزيع المساحة
                  child: Text(
                    "Email: ${user.email}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Colors.black.withValues(alpha: 0.7)),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.grey, size: 18), // أيقونة الهاتف
                const SizedBox(width: 8), // مسافة بين الأيقونة والنص
                Expanded( // هنا أيضًا تم استخدام Expanded
                  child: Text(
                    "Phone: ${user.phoneNumber}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Colors.black.withValues(alpha: 0.7)),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            Get.defaultDialog(
              title: "Delete User",
              middleText: "Are you sure you want to delete this user?",
              textConfirm: "Yes",
              textCancel: "Cancel",
              confirmTextColor: Colors.white,
              onConfirm: () {
                controller.deleteUser(user.id);
                Get.back();
              },
            );
          },
        ),
      ),
    );
  },
);

      }),
    );
  }
}
