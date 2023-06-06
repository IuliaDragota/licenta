import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleNewsScreen extends StatefulWidget {
  const ArticleNewsScreen({super.key, required this.blogUrl});

  final String blogUrl;

  @override
  State<ArticleNewsScreen> createState() => _ArticleNewsScreenState();
}

class _ArticleNewsScreenState extends State<ArticleNewsScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.blogUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: const <Widget>[
            Text(
              'Your',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'News',
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: WebViewWidget(controller: controller)),
    );
  }
}
