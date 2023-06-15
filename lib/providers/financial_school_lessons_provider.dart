import 'package:flutter/material.dart';
import 'package:licenta/models/fs_lesson.dart';
import 'package:licenta/services/financial_school_service.dart';

class FinancialSchoolLessons extends ChangeNotifier {
  List<FsLesson> lessons = <FsLesson>[];
  final service = FinancialSchoolService();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> fetchLessons() async {
    _isLoading = true;
    notifyListeners();

    lessons = await service.fetchLessons();

    _isLoading = false;
    notifyListeners();
  }
}