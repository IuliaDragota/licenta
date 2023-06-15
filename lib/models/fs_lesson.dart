class FsLesson {
  String id;
  String title;
  String content;

  FsLesson({
    required this.id,
    required this.title,
    required this.content,
  });

  factory FsLesson.fromJson(Map<dynamic, dynamic> json) {
    return FsLesson(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}
