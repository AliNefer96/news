import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/blocs/home/news/news_bloc.dart';
import 'package:news/blocs/home/news/news_event.dart';
import 'package:news/blocs/home/news/news_state.dart';
import 'package:news/screens/news/news_details_screen.dart';
import 'package:news/src/app_strings.dart';


class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
      appBar: AppBar(title: Text(AppStrings.newsTitle)),
      body: BlocBuilder<NewsBloc, NewsState>(
        buildWhen: (previous, current) => current is NewsLoaded || current is NewsError,
        builder: (context, state) {
          if (state is NewsLoading && context.read<NewsBloc>().allNews.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NewsError) {
            return Center(child: Text(state.message));
          } else if (state is NewsLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.news.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.news.length) {
                  return Center(child: CircularProgressIndicator());
                }
                final news = state.news[index];
                return ListTile(
                  title: Text(news.title),
                  subtitle: Text(news.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(news: news),
                      ),
                    );
                  },
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
