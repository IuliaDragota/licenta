import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:licenta/models/goal.dart';

class GoalItem extends StatelessWidget {
  GoalItem(
      {super.key,
      required this.goal,
      required this.onGoalChanged,
      required this.onDeleteItem});
  final Goal goal;
  final onGoalChanged;
  final onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onGoalChanged(goal);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          goal.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Color(0xFFc1dedc),
        ),
        title: Text(
          goal.goalText,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration: goal.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Color(0xFFc1dedc), borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              onDeleteItem(goal.id);
            },
          ),
        ),
      ),
    );
  }
}
