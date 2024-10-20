import 'package:flutter/material.dart';

import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/core/routes/routes.dart';
import 'package:the_movie_box/data/model/movie_model.dart';

import '../../widgets/widgets.dart';

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
          onTap: () => Navigator.of(context)
              .pushNamed(Routes.movieDetails, arguments: movie.id),
          child: CachedImageWidget(
              key: ValueKey(movie.id),
              fit: BoxFit.cover,
              imageUrl: APIConfig.imageURL + movie.posterPath),
        );
      },
    );
  }
}
