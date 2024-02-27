class Entity {
  final String? title;
  final String? shortDescription;
  final String wikiKey;
  String wikiTitle = "";
  String fullDescription = "";
  final bool isDownloaded;

  Entity({
    required this.title,
    required this.shortDescription,
    required this.wikiKey,
    required this.isDownloaded,
  });

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
      title: json['title'],
      shortDescription: json['description'],
      wikiKey: json['key'],
      isDownloaded: false,
    );
  }
}
