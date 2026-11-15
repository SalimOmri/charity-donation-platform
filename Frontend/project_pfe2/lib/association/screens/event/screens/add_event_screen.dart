import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pfe2/association/screens/event/controllers/event_controller.dart';
import 'package:project_pfe2/association/screens/event/models/event_model.dart';
import 'package:project_pfe2/auth_association/controllers/auth_association_controller.dart';
import 'package:project_pfe2/auth_association/models/association_model.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthAssociationController authController = Get.put(AuthAssociationController());
    final AssociationModel association = authController.association.value;
    final EventController eventController = Get.put(EventController());

    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final dateController = TextEditingController();
    final locationController = TextEditingController();

    // GetX reactive variables
    Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;
    RxString location = "Unknown".obs;
    RxString selectedType = "".obs;  // For dropdown selected value

    // Time picker function
    Future<void> selectTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime.value,
      );
      if (picked != null && picked != selectedTime.value) {
        selectedTime.value = picked;
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset(
                    "assets/logos/téléchargement.jpg",
                    height: 270,
                    width: 270,
                  ),
                ],
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Event Title',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.title),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter a title' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      hintText: 'YYYY-MM-DD',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.date_range),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Obx(() {
                        return Text(
                          "Time: ${selectedTime.value.format(context)}",
                          style: const TextStyle(fontSize: 16),
                        );
                      }),
                      IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () => selectTime(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Location input
                  TextFormField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    onChanged: (value) {
                      location.value = value.isEmpty ? "Unknown" : value;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Dropdown for type
                  Obx(() {
                    return DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Type',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.category),
                      ),
                      value: selectedType.value.isEmpty ? null : selectedType.value,
                      items: const [
                        DropdownMenuItem(value: "food", child: Text("food")),
                        DropdownMenuItem(value: "medicine", child: Text("medicine")),
                        DropdownMenuItem(value: "clothes", child: Text("clothes")),
                      ],
                      onChanged: (value) {
                        if (value != null) selectedType.value = value;
                      },
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please select a type' : null,
                    );
                  }),
                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final newEvent = Event(
                          id: 0,
                          title: titleController.text,
                          description: descriptionController.text,
                          date: dateController.text,
                          time: selectedTime.value.format(context),
                          location: location.value,
                          type: selectedType.value,  // Don't forget to add this field in your Event model
                          association: association,
                          donations: [],
                        );

                        eventController.createEvent(newEvent);

                        // Reset fields
                        titleController.clear();
                        descriptionController.clear();
                        dateController.clear();
                        locationController.clear();
                        selectedType.value = "";
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF008000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      child: Text(
                        "Add Event",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Your contribution makes a difference!",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
