import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FinancialLessonScreen extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;

  const FinancialLessonScreen(
      {super.key,
      required this.title,
      required this.content,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    print('ttt');
    print(imageUrl);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                    child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 300,
                  width: 400,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  content,
                  style: const TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
