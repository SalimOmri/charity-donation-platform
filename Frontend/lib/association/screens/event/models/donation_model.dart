import 'package:project_pfe2/association/screens/event/models/event_model.dart';
import 'package:project_pfe2/auth_user/models/user_model.dart';

class DonationModel {
  final int id;
  final String montant;
  final String items;
  final int eventId;
  final int userId;
  final UserModel? user;
  final Event? event;

  DonationModel({
    required this.id,
    required this.montant,
    required this.eventId,
    required this.userId,
    required this.items,
    this.user,
    this.event,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'montant': montant,
      'eventId': eventId,
      'items': items,
      'userId': userId,
    };
  }
  factory DonationModel.fromJson(Map<String, dynamic> json) => DonationModel(
    id: json['id'],
    montant: json['montant'],
    items: json['items'],
    eventId: json['event'] != null ? json['event']['id'] : 0,
    userId: json['user'] != null ? json['user']['id'] : 0,
    user: json['client'] != null ? UserModel.fromJson(json['client']) : null,
    event: json['event'] != null ? Event.fromJson(json['event']) : null,
  );
}
