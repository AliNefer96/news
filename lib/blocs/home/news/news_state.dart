import 'package:equatable/equatable.dart';
import 'package:news/models/news/news_model.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsArticle> news;
  final bool hasMore;

  NewsLoaded({required this.news, required this.hasMore});

  @override
  List<Object> get props => [news, hasMore];
}

class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
}
class NewsDetailsLoaded extends NewsState {
  final NewsArticle news;
  NewsDetailsLoaded(this.news);
}
