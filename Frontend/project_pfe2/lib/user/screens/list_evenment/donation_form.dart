import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_pfe2/association/screens/event/controllers/donation_controller.dart';
import 'package:project_pfe2/association/screens/event/controllers/event_controller.dart';

class DonationForm extends StatefulWidget {
  final String eventType;
  final int eventId;
  final int userId;

  const DonationForm({
    super.key,
    required this.eventType,
    required this.eventId,
    required this.userId,
  });

  @override
  State<DonationForm> createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController amountController;
  late TextEditingController itemsController;
  final DonationController donationController = Get.put(DonationController());
  final EventController eventController = Get.put(EventController());

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    itemsController = TextEditingController();
  }

  @override
  void dispose() {
    amountController.dispose();
    itemsController.dispose();
    super.dispose();
  }

  Future<void> _submitDonation() async {
    final String amountText = amountController.text.trim();
    String itemText = itemsController.text.trim();
    double? amount = double.tryParse(amountText);

    if ((amount == null || amount <= 0) && itemText.isEmpty) {
      Get.snackbar(
        'Invalid Input',
        'Please enter a valid amount or a useful item description.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    double finalAmount = amount != null && amount > 0 ? amount : 0;
    if (itemText.isEmpty) {
      itemText = 'No items donated';
    }

    setState(() {
      isLoading = true;
    });

    try {
final success = await donationController.makeDonation(
  widget.userId,
  widget.eventId,
  finalAmount,
  itemText,
);

if (success) {
  Get.back(); // Close the form

  await Future.delayed(const Duration(milliseconds: 300)); // Wait to ensure it's closed

  _showThankYouDialog(); // Show the dialog normally

  eventController.fetchAllEvents(); // Refresh events
} else {
  Get.snackbar(
    'Error',
    'Failed to process donation. Please try again.',
    backgroundColor: Colors.redAccent,
    colorText: Colors.white,
  );
}


    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: ${e.toString()}',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showThankYouDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 64),
              const SizedBox(height: 20),
              const Text(
                'Thank you for your donation!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Your contribution will make a difference 🙏',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32, 
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Close', 
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // User must click Close
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset(
                  "assets/svg_pictures/donation-heart-svgrepo-com (1).svg",
                  height: 80,
                  width: 80,
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'Donate to "${widget.eventType}" Event',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Money Donation (optional)',
                  labelStyle: const TextStyle(fontWeight: FontWeight.w500),
                  prefixIcon: const Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 18, 
                    horizontal: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: itemsController,
                maxLines: 4,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'What do you want to donate?',
                  labelStyle: const TextStyle(fontWeight: FontWeight.w500),
                  prefixIcon: const Icon(Icons.card_giftcard),
                  hintText: 'e.g. Clothes, Books, medical supplies...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 18, 
                    horizontal: 16,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : _submitDonation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF008000),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.favorite, color: Colors.white),
                  label: Text(
                    isLoading ? 'Processing...' : 'Confirm Donation',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}