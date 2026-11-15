import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pfe2/dashbord/controllers/association_controller.dart';

class EditAssociation extends StatelessWidget {
  const EditAssociation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AssociationController());
    final associationId = controller.association.id;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              _buildField(controller.nameController, controller.nameController.text),
              _buildField(controller.phoneController, controller.phoneController.text, TextInputType.phone),
              _buildField(controller.emailController, controller.emailController.text, TextInputType.emailAddress),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity / 0.75,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF008000)),
                  onPressed: () => controller.updateAssociations(associationId),
                  child: Text("Update", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController ctrl, String label, [TextInputType type = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: ctrl,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
