
import 'package:get/get.dart';
import 'package:project_pfe2/association/screens/main_association_screen.dart';
import 'package:project_pfe2/auth_association/models/association_model.dart';
import 'package:project_pfe2/auth_association/models/register_association_request.dart';
import 'package:project_pfe2/auth_association/services/auth_association_service.dart';
import 'package:project_pfe2/home/screens/inactive_association_screen.dart';

class AuthAssociationController extends GetxController {
  final AuthAssociationService _authService = AuthAssociationService();
  Rx<AssociationModel> association = AssociationModel.empty().obs;
  var isLoading = false.obs;

Future<void> login(String email, String password) async {
  try {
    isLoading.value = true;  
    final response = await _authService.login(email, password);  

    if (response.id != 0) {
      association.value = response;  
      if(association.value.statue == "accepted"){
        Get.to(MainAssociationScreen());
      }else{
        Get.to(InactiveAssociation());
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


  Future<void> register(RegisterAssociationRequest request) async {
    isLoading.value = true;
    final result = await _authService.register(request);
    if (result != null) {
      Get.offAllNamed("/loginAssociation");
    } else {
      Get.snackbar("Error", "Register failed");
    }
    isLoading.value = false;
  }
}
