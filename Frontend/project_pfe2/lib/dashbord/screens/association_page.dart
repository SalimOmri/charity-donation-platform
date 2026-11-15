import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/association_controller.dart';

class AssociationListScreen extends StatelessWidget {
  const AssociationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AssociationController());
    
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: controller.associations.length,
            itemBuilder: (context, index) {
              final a = controller.associations[index];
              // تحديد اللون الخلفي بناءً على الحالة
              Color backgroundColor = a.statue == "accepted" 
                  ? Colors.green.shade100 // حالة مقبولة: لون فاتح
                  : Colors.green.shade50;  // حالة غير مقبولة: لون أفتح

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: backgroundColor, // تلوين الخلفية بناءً على الحالة
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300), // إضافة حدود خفيفة
                  boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)], // إضافة ظلال خفيفة
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Icon(Icons.account_balance, color: const Color(0xFF008000)), // أيقونة باللون الأخضر
                  title: Text(
                    a.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "email: ",
                          style: TextStyle(
                            color: Colors.black.withValues(alpha: 0.6),
                          ),
                        ),
                        TextSpan(
                          text: a.email,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // زر حذف
                      TextButton(
                        onPressed: () {
                          controller.deleteAssociation(a.id);
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // زر قبول إذا كان غير مقبول
                      if (a.statue != "accepted")
                        TextButton(
                          onPressed: () {
                            controller.updateAssociation(a.id);
                          },
                          child: const Text(
                            "Accept",
                            style: TextStyle(
                              color: Color(0xFF008000), // اللون الأخضر هنا أيضًا
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
