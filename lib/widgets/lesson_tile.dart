import 'package:flutter/material.dart';
import 'package:licenta/screens/financial_lesson_screen.dart';

class LessonTile extends StatelessWidget {
  final String title, content;

  LessonTile({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FinancialLessonScreen(
                    title: title,
                    content: content,
                  )));
        },
        child: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2.0,
                blurRadius: 5.0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                content.length <= 100
                    ? content
                    : '${content.substring(0, 100)}...',
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ));
  }
}
