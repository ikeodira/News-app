import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/api/news_api.dart';
import 'package:news_app/model/news_model.dart';

final newsProvider = FutureProvider<List<NewsModel>>((ref) async {
  return ref.watch(newsApiServiceProvider).fetchNews();
});
