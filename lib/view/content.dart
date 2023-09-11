import 'package:flutter/material.dart';

class ContentPage extends StatelessWidget {
  final String title;
  final String description;
  final String content;
  const ContentPage(
      {super.key,
      required this.title,
      required this.description,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Text(description),
          Text(content),
        ],
      ),
    );
  }
}
