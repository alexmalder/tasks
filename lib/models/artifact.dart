import 'package:uuid/uuid.dart';

class Artifact {
  final Uuid id;
  final Uuid accountId;
  final String link;
  final String title;

  const Artifact({
    required this.id,
    required this.accountId,
    required this.link,
    required this.title,
  });

  factory Artifact.fromJson(Map<String, dynamic> json) {
    return Artifact(
      id: json['id'] as Uuid,
      accountId: json['account_id'] as Uuid,
      title: json['title'] as String,
      link: json['link'] as String,
    );
  }
}