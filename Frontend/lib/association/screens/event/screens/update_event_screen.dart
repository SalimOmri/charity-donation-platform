import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pfe2/association/screens/event/controllers/event_controller.dart';
import 'package:project_pfe2/association/screens/event/models/event_model.dart';

class UpdateEventScreen extends StatelessWidget {
  final Event event;

  UpdateEventScreen({super.key, required this.event});

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final EventController eventController = Get.put(EventController());

    // Initial values
    titleController.text = event.title;
    dateController.text = event.date;
    timeController.text = event.time;
    locationController.text = event.location;
    descriptionController.text = event.description;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Event'),
        backgroundColor: const Color(0xFF008000),
        foregroundColor: Colors.white,
        toolbarHeight: 75,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildField(titleController, 'Title'),
                _buildField(dateController, 'Date (YYYY-MM-DD)'),
                _buildField(timeController, 'Time (e.g. 14:00)'),
                _buildField(locationController, 'Location'),
                _buildField(descriptionController, 'Description'),
                const SizedBox(height: 24),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 60,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.update),
                    label: const Text('Update Event'),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF008000), foregroundColor: Colors.white,),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final updatedEvent = Event(
                          id: event.id,
                          title: titleController.text,
                          date: dateController.text,
                          time: timeController.text,
                          type: event.type,
                          location: locationController.text,
                          association: event.association, 
                          description: descriptionController.text,
                        );
                        await eventController.updateEvent(updatedEvent);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }
}
