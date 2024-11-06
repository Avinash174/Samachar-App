import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:smachara_app/models/news_category_model.dart';
import 'package:smachara_app/models/news_channel_headline_model.dart';

class NewsRepository {
  var logger = Logger();
  Future<NewsHeadlineChannelModel> fetchNewsChannelHeadlineApi(
      String channelName) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=605863575875479abbca9bdd2c420208";

    final response = await http.get(Uri.parse(url));

    if (kDebugMode) {
      logger.d(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsHeadlineChannelModel.fromJson(body);
    }
    throw Exception("Error");
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    String url =
        "https://newsapi.org/v2/everything?q=${category}&apiKey=605863575875479abbca9bdd2c420208";

    final response = await http.get(Uri.parse(url));

    if (kDebugMode) {
      logger.d(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception("Error");
  }
}
