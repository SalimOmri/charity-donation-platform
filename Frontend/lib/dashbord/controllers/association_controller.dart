import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pfe2/auth_association/controllers/auth_association_controller.dart';
import 'package:project_pfe2/auth_association/models/association_model.dart';
import '../services/association_service.dart';

class AssociationController extends GetxController {
  final associations = <AssociationModel>[].obs;
  final isLoading = false.obs;
  final _service = AssociationService();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final statusController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthAssociationController authAssociationController = Get.put(AuthAssociationController());
   late final AssociationModel association;
  @override
  void onInit() {
    super.onInit();
    association = authAssociationController.association.value;
    nameController.text = association.name;
    phoneController.text = association.phoneNumber;
    emailController.text = association.email;
    statusController.text = association.statue;
    passwordController.text = association.password;
    fetchAssociations();
  }

  Future<void> updateAssociations(int id) async {
    final data = {
      'name': nameController.text,
      'phoneNumber': phoneController.text,
      'email': emailController.text,
    };

    bool success = await _service.updateAssociation(id, data);

    if (success) {
      Get.snackbar("✅ Success", "Association data updated successfully",
        backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar("❌ Error", "Failed to update",
        backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
  void fetchAssociations() async {
    isLoading.value = true;
    associations.value = await _service.getAll();
    isLoading.value = false;
  }

  Future<void> updateAssociation(int id) async {
    await _service.update(id);
    fetchAssociations();
  }

  Future<void> deleteAssociation(int id) async {
    await _service.delete(id);
    fetchAssociations();
  }
}
