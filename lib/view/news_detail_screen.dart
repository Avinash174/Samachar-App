import 'package:flutter/material.dart';

class NewDetailScreeb extends StatefulWidget {
  final String newsTitle,
      newsImage,
      newsdate,
      author,
      description,
      content,
      source;

  const NewDetailScreeb({
    super.key,
    required this.author,
    required this.newsImage,
    required this.content,
    required this.description,
    required this.newsTitle,
    required this.newsdate,
    required this.source,
  });

  @override
  State<NewDetailScreeb> createState() => _NewDetailScreebState();
}

class _NewDetailScreebState extends State<NewDetailScreeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
