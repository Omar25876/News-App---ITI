// trending_news_widget.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/extensions/extensions.dart';
import 'package:news_app/core/theme/light.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class TrendingNews extends StatelessWidget {
  final bool isLoading;
  final List<NewsArticle> articles;

  const TrendingNews({
    super.key,
    required this.isLoading,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 335,
      child: Stack(
        children: [
          Image(
            image: const AssetImage('assets/images/background.png'),
            height: 265,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.darkGradientColor.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      'assets/images/newestText.svg',
                      width: 83,
                      height: 20,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trending News',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),

                      /// TODO : MAKE TRENDING NEWS SCREEN
                      Text(
                        'View all',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  isLoading
                      ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                      : SizedBox(
                        height: 140,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: articles.take(3).length,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (_, index) {
                            final article = articles[index];
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: article.urlToImage ?? '',
                                    height: 180,
                                    width: 280,
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (_, __) => Container(
                                          height: 180,
                                          width: 280,
                                          color: Colors.grey.shade400,
                                        ),
                                    errorWidget:
                                        (_, __, ___) => Container(
                                          height: 180,
                                          width: 280,
                                          color: Colors.grey.shade400,
                                        ),
                                  ),
                                  Positioned(
                                    left: 12,
                                    bottom: 12,
                                    right: 12,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article.title,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium?.copyWith(
                                            color:
                                                Theme.of(context).colorScheme.onPrimary,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            if (article.urlToImage != null)
                                              CircleAvatar(
                                                radius: 10,
                                                backgroundImage: NetworkImage(
                                                  article.urlToImage!,
                                                ),
                                              ),
                                            const SizedBox(width: 6),
                                            Text(
                                              article.sourceName,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium?.copyWith(
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.onPrimary,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              article.publishedAt.formatTimeAgo(),
                                              style:
                                                  Theme.of(context).textTheme.bodySmall,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
