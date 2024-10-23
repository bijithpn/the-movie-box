import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_movie_box/core/routes/routes.dart';
import 'package:the_movie_box/data/model/anime_details_model.dart';
import 'package:the_movie_box/view/widgets/cached_image.dart';

class AnimeRelatedWidget extends StatelessWidget {
  final List<RelatedAnime> relatedAnime;
  const AnimeRelatedWidget({
    super.key,
    required this.relatedAnime,
  });

  @override
  Widget build(BuildContext context) {
    return relatedAnime.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Related Animes",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 190,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: relatedAnime.length,
                      itemBuilder: (_, i) {
                        var show = relatedAnime[i];
                        return show.anime == null
                            ? const SizedBox.shrink()
                            : InkWell(
                                onTap: () {
                                  context.push(
                                    Routes.animeDetails(
                                      show.anime!.id,
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: CachedImageWidget(
                                      width: 130,
                                      key: ValueKey(show.id),
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          (show.anime?.poster.mainUrl ?? "")),
                                ),
                              );
                      }),
                )
              ],
            ),
          );
  }
}
