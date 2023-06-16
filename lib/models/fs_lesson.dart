class FsLesson {
  String id;
  String title;
  String content;
  String imageUrl;

  FsLesson({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  factory FsLesson.fromJson(Map<dynamic, dynamic> json) {
    return FsLesson(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        imageUrl: json['imageUrl']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
    };
  }
}
