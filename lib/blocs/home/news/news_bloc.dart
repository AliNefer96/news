import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/blocs/home/news/news_event.dart';
import 'package:news/blocs/home/news/news_state.dart';
import 'package:news/models/news/news_model.dart';
import 'package:news/network/news/news_api_serice.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsApiService _newsApiService;
  int currentPage = 0;
  List<NewsArticle> allNews = [];
  bool hasMore = true;

  NewsBloc(this._newsApiService) : super(NewsInitial()) {
    on<FetchNews>(_onFetchNews);
    on<FetchNewsDetails>(_onFetchNewsDetails); 
  }

  Future<void> _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
    if (!hasMore) return;

    try {
      emit(NewsLoading());
      final newsList = await _newsApiService.fetchNews(page: currentPage);

      if (newsList.isEmpty) {
        hasMore = false;
      } else {
        allNews.addAll(newsList);
      }

      emit(NewsLoaded(news: List.from(allNews), hasMore: hasMore));
    } catch (e) {
      emit(NewsError("Failed to load news"));
    }
  }

  Future<void> _onFetchNewsDetails(FetchNewsDetails event, Emitter<NewsState> emit) async {
    try {
      emit(NewsLoading());
      final newsDetail = await _newsApiService.fetchNewsDetails(event.newsId);
      emit(NewsDetailsLoaded(newsDetail));
    } catch (e) {
      emit(NewsError("Failed to load news details"));
    }
  }
}
