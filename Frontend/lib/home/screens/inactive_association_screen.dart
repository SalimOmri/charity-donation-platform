import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InactiveAssociation extends StatelessWidget {
  const InactiveAssociation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 75,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(
                onPressed: () {
                  Get.offAllNamed("/login");
                },
                icon: Icon(Icons.logout)),
          )
        ],
      ),
      body: Center(child: Text("Pending approval")),
    );
  }
}
