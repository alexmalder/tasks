class Artifact {
  final String id;
  final String accountId;
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
      id: json['id'] as String,
      accountId: json['account_id'] as String,
      title: json['title'] as String,
      link: json['link'] as String,
    );
  }
}