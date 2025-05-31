import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/extensions/extensions.dart';
import 'package:news_app/core/service_locator.dart';
import 'package:news_app/core/theme/light.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/features/home/repositories/base_news_api_repository.dart';
import 'package:provider/provider.dart';

import 'controller/search_controller.dart';

/// TODO : Task - Add Controller To It
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(),
      child: Scaffold(
        backgroundColor: Color(0xFFf5f5f5),
        appBar: AppBar(
            title: Text(
                'Search News',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Color(0xFF141414),
              fontWeight: FontWeight.w700
            ),),
            centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Consumer<SearchProvider>(
          builder: (context, provider, _) =>
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: provider.searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for news...',
                        hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Color(0xFFA0A0A0)
                        ),
                        suffix:  SvgPicture.asset(
                          'assets/images/searchIcon.svg',
                          width: 24,
                          height: 24,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Color(0xFFD1DAD6))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Color(0xFFD1DAD6))
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Color(0xFFD1DAD6))
                        ),

                      ),
                      onSubmitted: provider.searchNews,
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child:
                      provider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : provider.errorMessage != null
                          ? Center(child: Text(provider.errorMessage!))
                          : provider.articles.isEmpty
                          ? const Center(child: Text('No results found'))
                          : ListView.separated(
                        separatorBuilder: (context, index) => Divider(color: Color(0xFFD1DAD6)),
                        itemCount: provider.articles.length,
                        itemBuilder: (context, index) {
                          final article = provider.articles[index];
                          return ListTile(
                            leading: SvgPicture.asset(
                              'assets/images/searchIcon.svg',
                              width: 20,
                              height: 20,
                            ),
                            title: Text(article.title,
                            style: Theme.of(context).textTheme.labelSmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              '${article.sourceName} • ${article.publishedAt.formatTimeAgo()}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            onTap: () {
                              // TODO: Navigate to article details screen
                              Navigator.pushNamed(context, '/searchDetails', arguments: article);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }

}
