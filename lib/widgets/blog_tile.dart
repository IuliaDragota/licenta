import 'package:flutter/material.dart';
import 'package:licenta/Screens/article_news_screen.dart';

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  const BlogTile(
      {required this.imageUrl,
        required this.title,
        required this.desc,
        required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleNewsScreen(
                  blogUrl: url,
                )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl),
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              desc,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}