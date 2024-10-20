import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_box/core/config/api_config.dart';

import 'package:the_movie_box/data/model/review_model.dart';
import 'package:the_movie_box/view/widgets/cached_image.dart';

class ReviewWidget extends StatelessWidget {
  final List<Reviews> reviews;
  const ReviewWidget({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return reviews.isEmpty
        ? const SizedBox.shrink()
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            itemCount: reviews.length,
            itemBuilder: (_, i) {
              var review = reviews[i];
              return ListTile(
                titleAlignment: ListTileTitleAlignment.titleHeight,
                leading: CachedImageWidget(
                    width: 50,
                    height: 50,
                    imageUrl:
                        APIConfig.imageURL + review.authorDetails.avatarPath),
                title: Text(
                  "${review.author} (${review.authorDetails.username})",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Posted on: ${DateFormat('dd MMM yyyy').format(review.createdAt)}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      review.content,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            });
  }
}
