import 'package:flutter/material.dart';
import 'package:news/models/news/news_model.dart';
import 'package:news/src/app_strings.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle news;

  NewsDetailScreen({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(news.title)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(news.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("${AppStrings.newsCategory}: ${news.categoryTitle}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(news.description, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
