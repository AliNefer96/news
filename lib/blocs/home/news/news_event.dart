import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchNews extends NewsEvent {
  final int page;
  FetchNews(this.page);

  @override
  List<Object> get props => [page];
}
class FetchNewsDetails extends NewsEvent {
  final String newsId;
  FetchNewsDetails(this.newsId);
}

