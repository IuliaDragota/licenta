import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FinanciaSchool extends StatelessWidget {
  const FinanciaSchool({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Financial School',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xffE6DEF0),
        iconTheme: IconThemeData(
            color: Colors.black), // setează culoarea iconiței la negru
      ),
    );
  }
}
