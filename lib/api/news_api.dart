import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/constants/api_constants.dart';
import 'package:news_app/model/news_model.dart';
import 'package:http/http.dart' as http;

final newsApiServiceProvider =
    Provider<NewsApiServices>((ref) => NewsApiServices());

class NewsApiServices {
  Future<List<NewsModel>> fetchNews() async {
    final response = await http.get(Uri.parse(endpoints));

    if (response.statusCode == 200) {
      // return NewsModel.fromJson(jsonDecode(response.body));
      List data = jsonDecode(response.body)['articles'];
      return data.map((e) => NewsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
