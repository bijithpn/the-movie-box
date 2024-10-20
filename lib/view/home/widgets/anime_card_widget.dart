import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:the_movie_box/data/model/anime_model.dart';
// import 'package:the_movie_box/view/details/tv_anime_details.dart';

class AnimeCardWidget extends StatelessWidget {
  final List<Animes> animeList;
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
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => AnimeDetailsView(
            //               serieId: anime.id,
            //             )));
          },
          child: CachedNetworkImage(
              key: ValueKey(anime.id),
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Center(child: CircularProgressIndicator())),
              errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Center(child: Icon(Icons.error))),
              imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  )),
              imageUrl: anime.coverImage.large),
        );
      },
    );
  }
}
