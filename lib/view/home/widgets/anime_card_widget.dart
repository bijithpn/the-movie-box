import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_movie_box/core/routes/routes.dart';

import 'package:the_movie_box/data/model/anime_model.dart';

import '../../widgets/widgets.dart';
// import 'package:the_movie_box/view/details/tv_anime_details.dart';

class AnimeCardWidget extends StatelessWidget {
  final List<Anime> animeList;
  final ScrollController? scrollController;
  const AnimeCardWidget({
    super.key,
    required this.animeList,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: .6,
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: animeList.length,
      padding: const EdgeInsets.all(12.0),
      itemBuilder: (context, index) {
        var anime = animeList[index];
        return InkWell(
          onTap: () {
            context.push(Routes.animeDetails(anime.id));
          },
          child: CachedImageWidget(
              key: ValueKey(anime.id),
              fit: BoxFit.cover,
              imageUrl: anime.poster.mainUrl),
        );
      },
    );
  }
}
