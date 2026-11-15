import 'package:get/get.dart';
import 'package:project_pfe2/association/screens/event/models/donation_model.dart';
import 'package:project_pfe2/association/screens/event/services/donation_service.dart';
import 'package:project_pfe2/auth_user/controllers/auth_controller.dart';

class DonationController extends GetxController {
  final DonationService _service = DonationService();

  var isLoading = false.obs;
  var donations = <DonationModel>[].obs;
  final AuthController authController = Get.put(AuthController());
  late int userId;

  // إحصائيات عامة
  var totalDonations = 0.obs;
  var totalAmount = 0.0.obs;


  @override
  void onInit() {
    super.onInit();
    userId = authController.userModel.value.id;
    fetchUserDonations(userId);
  }

  Future<bool> makeDonation(int userId, int eventId, double montant, String items) async {
    isLoading.value = true;
    try {
      final success = await _service.makeDonation(userId, eventId, montant, items);
      if (success) {
        await fetchUserDonations(userId); // تحديث البيانات بعد التبرع
        Get.snackbar('Success', 'Donation successful');

        return true;
      } else {
        Get.snackbar('Failed', 'Donation failed');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while making the donation');
      return false;
    }
    finally {
      isLoading.value = false;
      
    }
  }

  Future<void> fetchUserDonations(int userId) async {
    isLoading.value = true;
    try {
      donations.value = await _service.getUserDonations(userId);

      // حساب الإحصائيات العامة
      totalDonations.value = donations.length;
      totalAmount.value = donations.fold(0, (sum, item) => sum + double.parse(item.montant));      
    } finally {
      isLoading.value = false;
    }
  }
    bool hasDonatedToEvent(int eventId, int userId) {
    return donations.any((donation) =>donation.event?.id == eventId && donation.user?.id == userId);
  }

}
