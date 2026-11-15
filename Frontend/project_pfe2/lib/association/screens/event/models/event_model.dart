import 'package:project_pfe2/association/screens/event/models/donation_model.dart';
import 'package:project_pfe2/auth_association/models/association_model.dart';

class Event {
  final int id;
  final String title;
  final String description;
  final String location;
  final String type;
  final String date;
  final String time;
  final AssociationModel association;
  final List<DonationModel> donations;

  Event({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.location,
    required this.date,
    required this.time,
    required this.association,
    this.donations = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'type': type,
      'date': date,
      'time': time,
      'association': association.toJson(),
      'donations': donations.map((donation) => donation.toJson()).toList(),
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      description: json['description'],
      location: json['location'],
      date: json['date'],
      time: json['time'],
      association: AssociationModel.fromJson(json['association']),
      donations: json['donations'] != null
          ? List<DonationModel>.from(
              json['donations'].map((donationJson) => DonationModel.fromJson(donationJson)))
          : [], // 🛡️ إذا null، يرجع قائمة فارغة
    );
  }

}
