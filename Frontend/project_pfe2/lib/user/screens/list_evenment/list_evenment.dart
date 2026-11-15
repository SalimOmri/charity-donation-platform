import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pfe2/association/screens/event/controllers/event_controller.dart';
import 'package:project_pfe2/auth_user/controllers/auth_controller.dart';
import 'package:project_pfe2/user/screens/list_evenment/donation_form.dart';

class ListEvenment extends StatelessWidget {
  const ListEvenment({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final userId = authController.userModel.value.id;
    final EventController eventController = Get.put(EventController());
    eventController.fetchAllEvents(); // نجلب الأحداث عند تحميل الشاشة
    return Scaffold(
      body: GetBuilder<EventController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final filteredEvents = controller.events
              .where((event) => event.type == controller.selectedType.value)
              .toList();

          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 0, bottom: 16, left: 16, right: 16),
                decoration: const BoxDecoration(
                  color: Color(0xFF008000),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: controller.availableAssociationTypes.map((type) {
                      final isSelected = type == controller.selectedType.value;
                      return GestureDetector(
                        onTap: () {
                          controller.selectedType.value = type;
                          controller.update(); // نحدّث الواجهة
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            type,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              // 🔹 Events List
              Expanded(
                child: filteredEvents.isEmpty
                    ? const Center(
                        child: Text(
                          'No events found for this association type.',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(12.0),
                        itemCount: filteredEvents.length,
                        itemBuilder: (context, index) {
                          final event = filteredEvents[index];
                          return Card(
                            color: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              leading: const CircleAvatar(
                                backgroundColor: Color(0xFF008000),
                                child: Icon(Icons.event, color: Colors.white),
                              ),
                              title: Text(
                                event.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text("📅 ${event.date} at ${event.time}"),
                                  Text("📍 ${event.location}"),
                                ],
                              ),
                              trailing: event.donations.any(
                                      (donation) => donation.user?.id == userId)
                                  ? const Text(
                                      "Donated",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF008000),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      onPressed: () async {
                                        await Get.bottomSheet(
                                          SingleChildScrollView(
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.95,
                                              child: DonationForm(
                                                eventType: event.type,
                                                eventId: event.id,
                                                userId: userId,
                                              ),
                                            ),
                                          ),
                                          backgroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(30)),
                                          ),
                                        );
                                        controller.fetchAllEvents(); // نجلب الأحداث من جديد
                                        controller.update(); // نحدّث الواجهة
                                      },
                                      child: const Text(
                                        "Donate",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
