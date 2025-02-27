import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/blocs/home/news/news_bloc.dart';
import 'package:news/blocs/home/news/news_state.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/screens/home/widgets/language_selector.dart';

class NewsDetailScreen extends StatelessWidget {
  final String newsId; 
  NewsDetailScreen({required this.newsId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions:[LanguageSelector()],
      title:  Text(AppLocalizations.of(context)!.newsDetails)),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NewsDetailsLoaded) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(state.news.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(state.news.description, style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          } else if (state is NewsError) {
            return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
