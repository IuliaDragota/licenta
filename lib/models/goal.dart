class Goal {
  String id;
  String goalText;
  bool isDone;

  Goal({required this.id, required this.goalText, this.isDone = false});

  factory Goal.fromJson(Map<dynamic, dynamic> json) {
    return Goal(
      id: json['id'],
      goalText: json['goalText'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'goalText': goalText,
      'isDone': isDone,
    };
  }
}
