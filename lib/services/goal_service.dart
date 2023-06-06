import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:licenta/models/goal.dart';

class GoalService {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  Future<List<Goal>> fetchGoals() async {
    if (userId == null) {
      return [];
    }

    final reference = await _databaseRef.child('goals/$userId').once();
    final goalMap = reference.snapshot.value as Map<dynamic, dynamic>?;
    if (goalMap == null) {
      return [];
    }

    final goals = goalMap.entries.map((entry) {
      return Goal.fromJson(entry.value);
    }).toList();

    goals.sort((a, b) => b.id.compareTo(a.id));
    return goals;
  }

  Future<void> addGoal(Goal goal) async {
    if (userId == null) {
      return;
    }
    final newGoalRef = _databaseRef.child('goals/$userId/${goal.id}');
    await newGoalRef.set(goal.toJson());
  }

  Future<void> removeGoal(String goalId) async {
    if (userId == null) {
      return;
    }
    await _databaseRef.child('goals/$userId/$goalId').remove();
  }

  Future<void> setIsDone(bool isDone, String goalId) async {
    if (userId == null) {
      return;
    }
    final isDoneRef = _databaseRef.child('goals/$userId/$goalId/isDone');
    await isDoneRef.set(isDone);
  }
}