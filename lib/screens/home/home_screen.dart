import 'package:flutter/material.dart';
import 'package:news/screens/news/news_list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsListScreen()),
            );
          },
          child: Text("View News"),
        ),
      ),
    );
  }
}
