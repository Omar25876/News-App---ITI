import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/core/extensions/extensions.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:provider/provider.dart';

import '../controller/home_controller.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle article;
  final bool isBookmarked;
  final Function()? onBookmarkPressed;

  const NewsCard({
    super.key,
    required this.article,
    this.isBookmarked = false,
    this.onBookmarkPressed,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/searchDetails', arguments: article);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [

            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(4),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? '',
                width: 122,
                height: 70,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(width: 122, color: Colors.grey.shade400),
                errorWidget:
                    (_, __, ___) => Container(width: 122, color: Colors.grey.shade400),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF141414),
                    ),
                  ),
                  Row(
                    children: [
                      if (article.urlToImage != null)
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(article.urlToImage!),
                        ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${article.sourceName} ${article.publishedAt.formatTimeAgo()}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,

                          ),
                          maxLines: 2,
                        ),
                      ),
                      //   Text(
                      //     article.sourceName,
                      //     style: Theme.of(context).textTheme.bodyMedium,
                      //     overflow: TextOverflow.ellipsis,
                      //     maxLines: 2,
                      //   ),
                      // ),

                      IconButton(
                        icon: Icon(
                          size: 20,
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color:
                          isBookmarked
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).iconTheme.color,
                        ),
                          onPressed: () {
                            final box = Hive.box('bookmarks');
                            if (isBookmarked) {
                              box.delete(article.url);
                            } else {
                              final category = Provider.of<HomeController>(context, listen: false).selectedCategory;
                              box.put(article.url, NewsArticle(
                                title: article.title,
                                urlToImage: article.urlToImage,
                                sourceName: article.sourceName,
                                publishedAt: article.publishedAt,
                                url: article.url,
                                description: article.description,
                                content: article.content,
                                author: article.author,
                                category: category, // Save selected category
                              ));
                            }
                          }

                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
