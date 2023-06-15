import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:licenta/providers/financial_school_lessons_provider.dart';
import 'package:licenta/widgets/lesson_tile.dart';
import 'package:provider/provider.dart';

class FinancialSchool extends StatefulWidget {
  const FinancialSchool({super.key});

  @override
  State<FinancialSchool> createState() => _FinancialSchoolState();
}

class _FinancialSchoolState extends State<FinancialSchool> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FinancialSchoolLessons>(context, listen: false)
          .fetchLessons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE5EFF9),
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Financial School',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xFFE5EFF9),
          iconTheme: const IconThemeData(
              color: Colors.black), // setează culoarea iconiței la negru
        ),
        body: Consumer<FinancialSchoolLessons>(
            builder: (context, lessonsProvider, _) {
          if (lessonsProvider.isLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Color(0xFFB494DB)));
          }
          return Container(
            padding: const EdgeInsets.only(top: 5),
            child: ListView.builder(
                itemCount: lessonsProvider.lessons.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return LessonTile(
                      title: lessonsProvider.lessons[index].title,
                      content: lessonsProvider.lessons[index].content);
                }),
          );
        }));
  }
}
