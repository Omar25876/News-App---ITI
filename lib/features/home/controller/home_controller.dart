import 'package:flutter/material.dart';
import 'package:news_app/core/service_locator.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/features/home/repositories/base_news_api_repository.dart';

class HomeController extends ChangeNotifier {
  final BaseNewsApiRepository _repository = locator<BaseNewsApiRepository>();

  List<NewsArticle> topHeadlines = [];
  List<NewsArticle> everythingArticles = [];
  bool isLoadingHeadlines = true;
  bool isLoadingEverything = true;
  String selectedCategory = 'Top News';


  final List<String> categories = [
    'Top News',
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];

  HomeController() {
    loadNews();
  }

  void setCategory(String category) {
    selectedCategory = category;
    notifyListeners();
    loadNews();
  }

  Future<void> loadNews() async {
    isLoadingHeadlines = true;
    isLoadingEverything = true;
    notifyListeners();

    try {
      final headlines = await _repository.fetchTopHeadlines(
        category: selectedCategory == 'Top News' ? 'general' : selectedCategory,
      );
      topHeadlines = headlines;
    } catch (_) {
      topHeadlines = [];
    } finally {
      isLoadingHeadlines = false;
    }

    try {
      final everything = await _repository.fetchEverything(
        query: selectedCategory == 'Top News' ? 'news' : selectedCategory,
      );
      everythingArticles = everything;
    } catch (_) {
      everythingArticles = [];
    } finally {
      isLoadingEverything = false;
      notifyListeners();
    }
  }
}
