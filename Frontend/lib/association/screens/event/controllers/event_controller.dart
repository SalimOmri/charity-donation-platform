import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:project_pfe2/association/controllers/association_navigation_controller.dart';
import 'package:project_pfe2/auth_association/controllers/auth_association_controller.dart';
import 'package:project_pfe2/auth_association/models/association_model.dart';
import '../services/event_service.dart';
import '../models/event_model.dart';

class EventController extends GetxController {
  final EventService _eventService = EventService();
  final logger = Logger();
  final AuthAssociationController authController = Get.put(AuthAssociationController());
  late final AssociationModel association;
  var isLoading = false.obs;
  final events = <Event>[].obs;
  final associationEvent = <Event>[].obs;
  String userAssociationType = "food";
  var availableAssociationTypes = <String>[].obs;
  var selectedType = ''.obs;
  var expandedEvents = <int, bool>{}.obs;

  void toggleEventExpansion(int eventId) {
    expandedEvents[eventId] = !(expandedEvents[eventId] ?? false);
    expandedEvents.refresh();
  }
  @override
  void onInit() {
    super.onInit();
    association = authController.association.value;
    fetchAllEventsByAssociationId();
    fetchAllEvents();
  }

Future<void> fetchAllEvents() async {
  isLoading.value = true;
  try {
    final fetchedEvents = await _eventService.getAllEvents();
    events.assignAll(fetchedEvents);
    logger.i("📦 Events fetched: ${events.length}");

    // استخراج الأنواع المتوفرة بدون تكرار
    final typesSet = <String>{};
    for (var event in fetchedEvents) {
      if (event.type.isNotEmpty) {
        typesSet.add(event.type);
      }
    }
    availableAssociationTypes.assignAll(typesSet.toList());
    logger.i("📌 Available Association Types: $availableAssociationTypes");
    if (availableAssociationTypes.isNotEmpty) {
      selectedType.value = availableAssociationTypes.first;
    }
    update();
  } catch (e) {
    logger.e("❌ Error fetching events: $e");
  } finally {
    isLoading.value = false;
  }
}

  
  Future<void> fetchAllEventsByAssociationId() async {
    isLoading.value = true;
    try {
      final fetchedEvents = await _eventService.getAllEventsByAssociationId(association.id);
      logger.i("📦 association id: ${association.id}");
      associationEvent.assignAll(fetchedEvents);
      logger.i("📦 Events fetched: ${associationEvent.length}");
    } catch (e) {
      logger.e("❌ Error fetching events: $e");
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> createEvent(Event event) async {
    isLoading.value = true;
    try {
      final success = await _eventService.addEvent(event);
      if (success) {
        logger.i("✅ Event created: ${event.title}");
        Get.snackbar(
          "Success ✅",
          "Event added successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green[100],
          colorText: Colors.black,
        );
        await fetchAllEvents();
        await fetchAllEventsByAssociationId();
        Get.find<AssociationNavigationController>().changeTab(0);
      } else {
        logger.w("❌ Failed to create event");
        Get.snackbar(
          "Failed ❌",
          "Could not add event",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.black,
        );
      }
    } catch (e) {
      logger.e("❌ Error while creating event: $e");
      Get.snackbar(
        "Error ❌",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.black,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateEvent(Event event) async {
    isLoading.value = true;
    try {
      final success = await _eventService.updateEvent(event);
      if (success) {
        logger.i("📝 Event updated: ${event.title}");
        Get.snackbar(
          "Success",
          "Event updated successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 2), // مدة الظهور
        );

        await fetchAllEvents();
        await fetchAllEventsByAssociationId();

        await Future.delayed(const Duration(milliseconds: 800)); // وقت كافي باش يبان Snackbar

        Get.find<AssociationNavigationController>().changeTab(0);
      }else {
        logger.w("❌ Failed to update event");
        Get.snackbar(
          "Failed ❌",
          "Failed to update event",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.black,
        );
      }
    } catch (e) {
      logger.e("❌ Error updating event: $e");
      Get.snackbar(
        "Error ❌",
        "❌ Error: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.black,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteEvent(int id) async {
    isLoading.value = true;
    try {
      final success = await _eventService.deleteEvent(id);
      if (success) {
        logger.i("🗑️ Event deleted: ID $id");
        Get.snackbar(
          "Success",
          "Event deleted successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        await fetchAllEvents(); // Refresh list
        await fetchAllEventsByAssociationId();
      } else {
        logger.w("❌ Failed to delete event");
        Get.snackbar(
          "Error ",
          "Failed to delete event",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.black,
        );
      }
    } catch (e) {
      logger.e("❌ Error deleting event: $e");
      Get.snackbar(
        "Error ❌",
        "❌ Error: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.black,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
