class BlogModel {
  final String title;
  final String description;
  final String category;
  final String tags;
  final String imageUrl;
  final String? id;

  BlogModel(
      {this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.tags,
      required this.imageUrl});

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        category: json['category'],
        tags: json['tags'],
        imageUrl: json['imageUrl']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'tags': tags,
      'imageUrl': imageUrl
    };
  }
}
