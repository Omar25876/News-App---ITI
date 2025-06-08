import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../../core/consts/storage_keys.dart';
import '../home/controller/home_controller.dart';
import '../home/models/news_article_model.dart';
import '../home/widgets/category_list_widget.dart';
import '../home/widgets/news_card.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}



class _BookmarkScreenState extends State<BookmarkScreen> {
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<HomeController>(context, listen: false);
    selectedCategory = provider.selectedCategory;
  }

  List<String> getCategories(Box box) {
    final List<String> categories = [];
    for (var i = 0; i < box.length; i++) {
      final article = box.getAt(i) as NewsArticle;
      if (article.category != null && !categories.contains(article.category)) {
        categories.add(article.category!);
      }
    }
    return categories;
  }

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
        body: ValueListenableBuilder(
          valueListenable: Hive.box(StorageKeys.bookmarks).listenable(),
          builder: (context, Box box, _) {
            if (box.isEmpty) {
              return const Center(child: Text('No bookmarked articles yet'));
            }

            final categories = getCategories(box);
            final filtered = box.values.where((article) {
              if (selectedCategory == null) return true;
              return article.category == selectedCategory;
            }).toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: CategoryList(
                    categories: provider.categories,
                    selectedCategory: selectedCategory!,
                    onCategorySelected: (category) {
                      setState(() {
                        selectedCategory = category;
                        provider.selectedCategory = category;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                      child:
                      Text(
                          'No bookmarked articles in $selectedCategory',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16
                          )))
                      : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final article = filtered[index] as NewsArticle;
                      return NewsCard(
                        article: article,
                        isBookmarked: true,
                        onBookmarkPressed: () {
                          box.delete(article.url);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
