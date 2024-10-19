import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/data/model/movie_model.dart';
import 'package:the_movie_box/view/details/movie_details.dart';

class MovieCardWidget extends StatelessWidget {
  final List<Show> movieList;
  final ScrollController? scrollController;
  const MovieCardWidget({
    super.key,
    required this.movieList,
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
      itemCount: movieList.length,
      padding: const EdgeInsets.all(12.0),
      itemBuilder: (context, index) {
        var movie = movieList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetailsView(
                          moiveId: movie.id,
                        )));
          },
          child: CachedNetworkImage(
              key: ValueKey(movie.id),
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Center(child: CircularProgressIndicator())),
              imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  )),
              imageUrl: APIConfig.imageURL + movie.posterPath),
        );
      },
    );
  }
}
