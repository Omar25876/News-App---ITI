import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/core/consts/storage_keys.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
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


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Color(0xFF141414),
                          ),
                        ),

                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/categories');
                          },
                          child: Text(
                            'View all',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              decoration: TextDecoration.underline,
                              color: Color(0xFF141414),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CategoryList(
                      categories: provider.categories,
                      selectedCategory: provider.selectedCategory,
                      onCategorySelected: (category) {
                        setState(() => provider.selectedCategory = category);
                        provider.loadNews();
                      },
                    ),
                  ],
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
                :
            SliverToBoxAdapter(
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
    );
  }
}
