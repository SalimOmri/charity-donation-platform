import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pfe2/auth_user/controllers/auth_controller.dart';
import 'package:project_pfe2/dashbord/controllers/user_controller.dart';

class EditProfil extends StatelessWidget {
  const EditProfil({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    final AuthController authController = Get.put(AuthController());
    final userId = authController.userModel.value.id;

    return Scaffold(
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: userController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("First Name"),
                  _buildInput(userController.firstnameController),

                  _buildLabel("Last Name"),
                  _buildInput(userController.lastnameController),

                  _buildLabel("Email"),
                  _buildInput(userController.emailController, TextInputType.emailAddress),

                  _buildLabel("Phone Number"),
                  _buildInput(userController.phoneController, TextInputType.phone),

                  _buildLabel("Gender"),
                  DropdownButtonFormField<String>(
                    value: _normalizeGender(userController.genderController.text),
                    items: ['Male', 'Female'].map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) {
                      userController.genderController.text = value ?? '';
                    },
                    decoration: _inputDecoration(),
                  ),

                  _buildLabel("Date of Birth"),
                  TextFormField(
                    controller: userController.dobController,
                    readOnly: true,
                    decoration: _inputDecoration().copyWith(
                      suffixIcon: const Icon(Icons.calendar_today),
                      hintText: "YYYY-MM-DD",
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().subtract(Duration(days: 365 * 18)),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                        userController.dobController.text = formattedDate;
                      }
                    },
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => userController.updateUser(userId),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF008000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Update Profile',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🏷 Label Builder
  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 6),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }

  /// 🧾 Input Field Builder
  Widget _buildInput(TextEditingController controller, [TextInputType keyboardType = TextInputType.text]) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _inputDecoration(),
    );
  }

  /// ✏️ Unified Input Decoration
  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF008000), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  /// 👤 Gender Normalizer
  String? _normalizeGender(String gender) {
    if (gender.toLowerCase() == 'male') return 'Male';
    if (gender.toLowerCase() == 'female') return 'Female';
    return null;
  }
}
