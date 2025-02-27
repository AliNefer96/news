import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/blocs/home/news/news_bloc.dart';
import 'package:news/blocs/home/news/news_event.dart';
import 'package:news/blocs/home/news/news_state.dart';
import 'package:news/screens/news/news_details_screen.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(FetchNews(0));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        context.read<NewsBloc>().add(FetchNews(context.read<NewsBloc>().currentPage));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsBloc, NewsState>(
        buildWhen: (previous, current) => current is NewsLoaded || current is NewsError,
        builder: (context, state) {
          if (state is NewsLoading && context.read<NewsBloc>().allNews.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NewsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 40),
                  SizedBox(height: 10),
                  Text(state.message, style: TextStyle(fontSize: 16, color: Colors.red)),
                ],
              ),
            );
          } else if (state is NewsLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.news.length + (state.hasMore ? 1 : 0),
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                if (index == state.news.length) {
                  return Center(child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircularProgressIndicator(),
                  ));
                }
                final news = state.news[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: Icon(Icons.article, size: 50, color: Colors.grey),
                    title: Text(news.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(news.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey[700])),
                    onTap: () {
  context.read<NewsBloc>().add(FetchNewsDetails(news.id)); 

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NewsDetailScreen(newsId: news.id),
    ),
  );
},

                  ),
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
