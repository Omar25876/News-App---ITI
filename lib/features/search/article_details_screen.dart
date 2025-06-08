import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/extensions/extensions.dart';

import '../home/models/news_article_model.dart';

class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as NewsArticle;

    return Scaffold(
      appBar: AppBar(
        title: Text('News Details',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Color(0xFF141414),
              fontWeight: FontWeight.w700
          ),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? '',
                width: double.infinity,
                height: 228,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(width: 122, color: Colors.grey.shade400),
                errorWidget:
                    (_, __, ___) => Container(width: 122, color: Colors.grey.shade400),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Color(0xFF141414),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey.shade300,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: article.urlToImage ?? '',
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        width: 32,
                        height: 32,
                        color: Colors.grey.shade400,
                      ),
                      errorWidget: (_, __, ___) => Container(
                        width: 32,
                        height: 32,
                        color: Colors.grey.shade400,
                        child: const Icon(Icons.error, size: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                article.sourceName,
                  style:Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF141414),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    article.publishedAt.formatTimeAgo(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF363636),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: SvgPicture.asset('assets/images/shareIcon.svg',
                  width: 24,
                  height: 24,),
                  onPressed: () {},
                ),
                IconButton(
                  icon: SvgPicture.asset('assets/images/bookmarkIcon.svg',
                    width: 24,
                    height: 24,),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              article.description??'',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Color(0xFF363636),
                height: 2,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
