class Artifact {
  final int userId;
  final int id;
  final String title;

  const Artifact({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Artifact.fromJson(Map<String, dynamic> json) {
    return Artifact(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }
}