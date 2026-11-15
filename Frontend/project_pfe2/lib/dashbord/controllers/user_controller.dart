import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:project_pfe2/auth_user/controllers/auth_controller.dart';
import 'package:project_pfe2/auth_user/models/user_model.dart';
import '../services/user_service.dart';

class UserController extends GetxController {
  var users = <UserModel>[].obs;
  var isLoading = false.obs;
  final _service = UserService();
  final logger = Logger();
  final AuthController authController = Get.put(AuthController());
  late final UserModel user;

  @override
  void onInit() {
    user = authController.userModel.value;
    firstnameController = TextEditingController(text: user.firstname);
    lastnameController = TextEditingController(text: user.lastname);
    emailController = TextEditingController(text: user.email);
    phoneController = TextEditingController(text: user.phoneNumber);
    genderController = TextEditingController(text: user.gender);
    dobController = TextEditingController(text: user.dateOfBirth);
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    isLoading.value = true;
    try {
      users.value = await _service.getAllUsers();
    } catch (e) {
      logger.e("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController firstnameController;
  late final TextEditingController lastnameController ;
  late final TextEditingController emailController ;
  late final TextEditingController phoneController ;
  late final TextEditingController genderController ;
  late final TextEditingController dobController ;

  Future<void> updateUser(int userId) async {
    Map<String, dynamic> updates = {
      "firstname": firstnameController.text,
      "lastname": lastnameController.text,
      "email": emailController.text,
      "phoneNumber": phoneController.text,
      "gender": genderController.text,
      "dateOfBirth": dobController.text,
    };

    UserService userService = UserService();
    var result = await userService.updateUser(userId, updates);

    if (result != null) {
      Get.snackbar('Success', '✅ User updated successfully', backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar('Error', '❌ Update failed', backgroundColor: Colors.red, colorText: Colors.white, );
    }
  }

  Future<void> deleteUser(int id) async {
    await _service.deleteUser(id);
    fetchUsers();
  }
}
