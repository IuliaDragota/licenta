import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:licenta/models/goal.dart';
import 'package:licenta/providers/goals_provider.dart';
import 'package:licenta/widgets/goals_item.dart';
import 'package:provider/provider.dart';

class GoalsScreen extends StatefulWidget {
  GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final _goalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Goals>(context, listen: false).fetchGoals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Goals>(builder: (context, goalsProvider, _) {
      return Scaffold(
        backgroundColor: Color(0xFFE5EFF9),
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFFE5EFF9),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Set your Goals',
              style: TextStyle(color: Colors.black),
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(6.0),
                child: goalsProvider.isLoading
                    ? const LinearProgressIndicator(
                        color: Colors.deepPurpleAccent,
                        backgroundColor: Color(0xFFB494DB))
                    : const SizedBox())),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 50, bottom: 20),
                          child: const Text(
                            'All Goals',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                        for (Goal goal in goalsProvider.foundGoal.reversed)
                          GoalItem(
                            goal: goal,
                            onGoalChanged: _handleGoalChane,
                            onDeleteItem: _deleteGoalItem,
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _goalController,
                      decoration: const InputDecoration(
                          hintText: 'Add your goals', border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addGoalItem(_goalController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFc1dedc),
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                )
              ]),
            )
          ],
        ),
      );
    });
  }

  void _handleGoalChane(Goal goal) {
    Provider.of<Goals>(context, listen: false).toggleIsDone(goal.id);
  }

  void _deleteGoalItem(String id) {
    Provider.of<Goals>(context, listen: false).deleteGoal(id);
  }

  void _addGoalItem(String goal) {
    if (goal.isEmpty) {
      return;
    }
    Provider.of<Goals>(context, listen: false).addGoal(
      Goal(
          id: DateTime.now().microsecondsSinceEpoch.toString(), goalText: goal),
    );
    _goalController.clear();
  }

  void _runFilter(String enteredKeyword) {
    Provider.of<Goals>(context, listen: false).runFilter(enteredKeyword);
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
