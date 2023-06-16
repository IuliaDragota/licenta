import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:licenta/models/fs_lesson.dart';

class FinancialSchoolService {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  Future<List<FsLesson>> fetchLessons() async {
    final reference = await _databaseRef.child('financial_school').once();
    final lessonsMap = reference.snapshot.value as Map<dynamic, dynamic>?;
    if (lessonsMap == null) {
      return [];
    }

    final lessons = lessonsMap.entries.map((entry) {
      return FsLesson.fromJson(entry.value);
    }).toList();

    lessons.sort((a, b) => a.id.compareTo(b.id));
    return lessons;
  }
}
