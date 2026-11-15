import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pfe2/association/screens/event/controllers/event_controller.dart';
import 'package:project_pfe2/association/screens/event/screens/update_event_screen.dart';

class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EventController eventController = Get.put(EventController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Obx(() {
        if (eventController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (eventController.associationEvent.isEmpty) {
          return const Center(
            child: Text(
              'No events found.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: eventController.associationEvent.length,
          itemBuilder: (context, index) {
            final event = eventController.associationEvent[index];

            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.green[100],
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(Icons.event, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.date_range,
                                      color: Colors.green, size: 18),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      "${event.date} at ${event.time}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isDark
                                            ? Colors.grey[300]
                                            : Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.location_on, color: Colors.green, size: 18),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      event.location,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isDark
                                            ? Colors.grey[400]
                                            : Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Get.to(() => UpdateEventScreen(event: event));
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "Delete Event",
                                  middleText:
                                      "Are you sure you want to delete this event?",
                                  textConfirm: "Yes",
                                  textCancel: "No",
                                  confirmTextColor: Colors.white,
                                  onConfirm: () async {
                                    Get.back();
                                    await eventController.deleteEvent(event.id);
                                  },
                                  backgroundColor:
                                      isDark ? Colors.grey[800]! : Colors.white,
                                  buttonColor: Colors.red,
                                  radius: 8,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Obx(() {
                      final isExpanded = eventController.expandedEvents[event.id] == true;
                      return Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: AnimatedRotation(
                            turns: isExpanded ? 0.5 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: Icon(Icons.expand_more,
                                color: Colors.grey[600]),
                          ),
                          onPressed: () {
                            eventController.toggleEventExpansion(event.id);
                          },
                        ),
                      );
                    }),
                    Obx(() {
                      return eventController.expandedEvents[event.id] == true
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: event.donations.isEmpty
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: Text(
                                        'No donors for this event yet.',
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.grey[400]
                                              : Colors.grey[600],
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ...event.donations.map((donor) =>
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 24,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(Icons.person,
                                                        color: Colors.green,
                                                        size: 40),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${donor.user!.firstname} ${donor.user!.lastname}",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: isDark
                                                                ? Colors.white
                                                                : Colors
                                                                    .black87,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Amount: ${donor.montant} DT',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: isDark
                                                                ? Colors
                                                                    .grey[400]
                                                                : Colors
                                                                    .grey[600],
                                                          ),
                                                        ),
                                                        Text(
                                                          'Items: ${donor.items}',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: isDark
                                                                ? Colors
                                                                    .grey[400]
                                                                : Colors
                                                                    .grey[600],
                                                          ),
                                                        ),
                                                        Text(
                                                          'Phone: ${donor.user!.phoneNumber}',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: isDark
                                                                ? Colors
                                                                    .grey[400]
                                                                : Colors
                                                                    .grey[600],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                            )
                          : const SizedBox.shrink();
                    }),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
