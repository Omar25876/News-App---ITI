import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/core/consts/storage_keys.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/service_locator.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/features/home/repositories/base_news_api_repository.dart';
import 'package:news_app/features/home/repositories/news_api_repository.dart';
import 'package:news_app/features/home/widgets/category_list_widget.dart';
import 'package:news_app/features/home/widgets/news_card.dart';
import 'package:news_app/features/home/widgets/trending_news_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  /// TODO : Task - Make Provider For This

  // Future<void> _loadNews() async {
  //   setState(() {
  //     _isLoadingHeadlines = true;
  //     _isLoadingEverything = true;
  //   });
  //
  //   try {
  //     final headlines = await _repository.fetchTopHeadlines(
  //       category: selectedCategory == 'Top News' ? 'general' : selectedCategory,
  //     );
  //     setState(() {
  //       _topHeadlines = headlines;
  //       _isLoadingHeadlines = false;
  //     });
  //   } catch (_) {
  //     setState(() {
  //       _topHeadlines = [];
  //       _isLoadingHeadlines = false;
  //     });
  //   }
  //
  //   try {
  //     final everything = await _repository.fetchEverything(
  //       query: selectedCategory == 'Top News' ? 'news' : selectedCategory,
  //     );
  //     setState(() {
  //       _everythingArticles = everything;
  //       _isLoadingEverything = false;
  //     });
  //   } catch (_) {
  //     setState(() {
  //       _everythingArticles = [];
  //       _isLoadingEverything = false;
  //     });
  //   }
  // }

  /// TODO : Task - Make this extension
  // String _formatTimeAgo(DateTime time) {
  //   final diff = DateTime.now().difference(time);
  //   if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  //   if (diff.inHours < 24) return '${diff.inHours}h ago';
  //   return '${diff.inDays}d ago';
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(),
      child: Consumer<HomeController>(
        builder: (context, provider, _) =>
         Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: TrendingNews(
                  isLoading: provider.isLoadingHeadlines,
                  articles: provider.topHeadlines,

                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: CategoryList(
                    categories: provider.categories,
                    selectedCategory: provider.selectedCategory,
                    onCategorySelected: (category) {
                      setState(() => provider.selectedCategory = category);
                      provider.loadNews();
                    },
                  ),
                ),
              ),
              provider.isLoadingEverything
                  ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  )
                  : SliverToBoxAdapter(
                    child: ValueListenableBuilder(
                      valueListenable: Hive.box(StorageKeys.bookmarks).listenable(),
                      builder: (context, Box box, _) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.everythingArticles.length,
                          itemBuilder: (context, index) {
                            final article = provider.everythingArticles[index];
                            final isBookmarked = box.containsKey(article.url);
                            return NewsCard(
                              article: article,
                              isBookmarked: isBookmarked,
                            );
                          },
                        );
                      },
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
