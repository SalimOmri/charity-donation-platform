import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pfe2/association/screens/event/controllers/event_controller.dart';
import 'package:project_pfe2/dashbord/controllers/association_controller.dart';
import 'package:project_pfe2/dashbord/controllers/user_controller.dart';

class AdminStatisticsPage extends StatelessWidget {

  const AdminStatisticsPage({super.key});


  @override
  Widget build(BuildContext context) {
    final AssociationController associationController = Get.put(AssociationController());
    final UserController userController = Get.put(UserController());
    final EventController eventController = Get.put(EventController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Obx(() {
        return Container(
          color: Colors.green[200],
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 1,
                  shrinkWrap: true,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2,
                  children: [
                    StatCard(
                      title: 'DONORS',
                      count: userController.users.length,
                      icon: Icons.people_alt,
                      color: Colors.blue,

                    ),
                    StatCard(
                      title: 'ASSOCIATIONS',
                      count: associationController.associations.length,
                      icon: Icons.account_balance,
                      color: Colors.orange,

                    ),
                    StatCard(
                      title: 'EVENTS',
                      count: eventController.events.length,
                      icon: Icons.event,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}


class StatCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;
  final String? trend;
  final String? trendText;
  final VoidCallback? onTapLink;
  final String? linkText;

  const StatCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    this.trend,
    this.trendText,
    this.onTapLink,
    this.linkText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        // color: Colors.green[200],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            if (trend != null && trendText != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    trend!,
                    style: TextStyle(
                      color: trend!.startsWith('+') ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    trendText!,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
            if (onTapLink != null && linkText != null) ...[
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: onTapLink,
                  child: Text(
                    linkText!,
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}