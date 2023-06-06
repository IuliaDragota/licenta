import 'package:flutter/foundation.dart';
import 'package:licenta/models/goal.dart';
import 'package:licenta/services/goal_service.dart';

class Goals extends ChangeNotifier {
  List<Goal> goals = <Goal>[];
  List<Goal> foundGoal = [];
  var enteredKeyword = '';
  final service = GoalService();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> fetchGoals() async {
    _isLoading = true;
    notifyListeners();

    goals = await service.fetchGoals();
    foundGoal = goals;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addGoal(Goal goal) async {
    _isLoading = true;
    notifyListeners();

    await service.addGoal(goal);

    _isLoading = false;
    goals.add(goal);
    goals.sort((a, b) => b.id.compareTo(a.id));

    if (goal.goalText
        .toLowerCase()
        .contains(enteredKeyword.toLowerCase()) && enteredKeyword.isNotEmpty) {
      foundGoal.add(goal);
      foundGoal.sort((a, b) => b.id.compareTo(a.id));
    }

    notifyListeners();
  }

  void deleteGoal(String id) async {
    _isLoading = true;
    notifyListeners();

    await service.removeGoal(id);

    _isLoading = false;
    goals.removeWhere((tx) => tx.id == id);
    foundGoal.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }

  void toggleIsDone(String id) async {
    _isLoading = true;
    notifyListeners();

    var goal = goals.firstWhere((element) => element.id == id);
    goal.isDone = !goal.isDone;

    await service.setIsDone(goal.isDone, id);

    _isLoading = false;
    notifyListeners();
  }

  void runFilter(String enteredKeyword) {
    this.enteredKeyword = enteredKeyword;
    List<Goal> results = [];
    if (enteredKeyword.isEmpty) {
      results = goals;
    } else {
      results = goals
          .where((item) => item.goalText
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    foundGoal = results;
    notifyListeners();
  }
}