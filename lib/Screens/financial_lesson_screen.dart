import 'package:flutter/material.dart';

class FinancialLessonScreen extends StatelessWidget {
  final String title;
  final String content;

  const FinancialLessonScreen({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xffE6DEF0),
        iconTheme: const IconThemeData(
            color: Colors.black
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: const TextStyle(fontSize: 18.0),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
  }
}