import 'package:get/get.dart';
import 'package:project_pfe2/auth_user/models/register_request.dart';
import 'package:project_pfe2/auth_user/models/user_model.dart';
import 'package:project_pfe2/auth_user/services/auth_service.dart';
import 'package:project_pfe2/user/screens/main_user_screen.dart';
import 'package:project_pfe2/dashbord/dashbord_screen.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  Rx<UserModel> userModel = UserModel.empty().obs;
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final response = await _authService.login(email, password);

      if (response.id != 0) {
        userModel.value = response;
        if (userModel.value.role == "USER") {
          Get.to(MainUserScreen());
        } else {
          Get.to(AdminHomeScreen());
        }
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "Login failed");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "An error occurred: $e");
    }
    isLoading.value = false;
  }

  Future<void> register(RegisterRequest request) async {
    isLoading.value = true;
    final result = await _authService.register(request);
    if (result != null) {
      Get.offAllNamed("/login");
    } else {
      Get.snackbar("Error", "Register failed");
    }
    isLoading.value = false;
  }
}
