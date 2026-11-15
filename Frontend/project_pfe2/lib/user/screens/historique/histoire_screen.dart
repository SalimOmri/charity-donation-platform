import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pfe2/association/screens/event/controllers/donation_controller.dart';

class HistoireScreen extends StatelessWidget {
  const HistoireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DonationController controller = Get.put(DonationController());
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Statistiques Card
Card(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  elevation: 6,
  color: Colors.teal.shade50,
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatColumn(
              label: 'Nombre de Donations',
              value: '${controller.totalDonations.value}',
              icon: Icons.favorite,
              iconColor: Colors.redAccent,
            ),
            _buildStatColumn(
              label: 'Montant Total',
              value: '${controller.totalAmount.value.toStringAsFixed(2)} DT',
              icon: Icons.monetization_on,
              iconColor: Colors.amber.shade700,
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    ),
  ),
),

              const SizedBox(height: 30),

              // Titre historique
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Historique des Donations',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Liste des donations
              Expanded(
                child: controller.donations.isEmpty
                    ? Center(
                        child: Text(
                          'Aucune donation trouvée',
                          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                        ),
                      )
                    : ListView.separated(
                        itemCount: controller.donations.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final donation = controller.donations[index];
                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 3,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.teal.shade100,
                                child: Icon(Icons.event, color: Colors.teal.shade700),
                              ),
                              title: Text(
                                donation.event?.title ?? "Evénement Inconnu",
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Montant: ${double.parse(donation.montant).toStringAsFixed(2)} DT',
                                    style: const TextStyle(color: Colors.black87),
                                  ),
                                  Text(
                                    'Donation: ${donation.items}',
                                    style: const TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                'ID: ${donation.id}',
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatColumn({
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Icon(icon, size: 36, color: iconColor),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }
}
