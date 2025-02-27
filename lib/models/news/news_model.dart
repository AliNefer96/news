class NewsArticle {
  final String id;
  final String title;
  final String description;
  final String categoryTitle;
  final String thumbnailPictureId;
  final String creationDate;
  final bool isActive;

  NewsArticle({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryTitle,
    required this.thumbnailPictureId,
    required this.creationDate,
    required this.isActive,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json["id"] ?? "",
      title: json["title"] ?? "No Title",
      description: json["description"] ?? "No Description",
      categoryTitle: json["categoryTitle"] ?? "Uncategorized",
      thumbnailPictureId: json["thumbnailPictureId"] ?? "",
      creationDate: json["creationDateUtc"] ?? "",
      isActive: json["isActive"] ?? false,
    );
  }
  factory NewsArticle.fromJsonDetails(Map<String, dynamic> json) {
    return NewsArticle(
      id: json["id"] ?? "",
      title: json["title"] ?? "No Title",
      description: json["content"] ?? "No Description",
      categoryTitle: json["categoryTitle"] ?? "Uncategorized",
      thumbnailPictureId: json["thumbnailPictureId"] ?? "",
      creationDate: json["creationDateUtc"] ?? "",
      isActive: json["isActive"] ?? false,
    );
  }
}
