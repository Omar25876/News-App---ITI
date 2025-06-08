import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../../core/consts/storage_keys.dart';
import '../home/controller/home_controller.dart';
import '../home/widgets/category_list_widget.dart';
import '../home/widgets/news_card.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, provider, _) =>
          Scaffold(
            backgroundColor: Color(0xFFf5f5f5),
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                  'Categories',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Color(0xFF141414),
                    fontWeight: FontWeight.w700,
                  )),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
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
          ),
    );
  }
}
