import 'package:smachara_app/models/news_category_model.dart';
import 'package:smachara_app/models/news_channel_headline_model.dart';
import 'package:smachara_app/repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();

  Future<NewsHeadlineChannelModel> fetchNewsChannelsApi(
      String channelName) async {
    final response = await _repo.fetchNewsChannelHeadlineApi(channelName);
    return response;
  }

  Future<CategoriesNewsModel> fetchNewsCategoriesApi(String categories) async {
    final response = await _repo.fetchCategoriesNewsApi(categories);
    return response;
  }
}
