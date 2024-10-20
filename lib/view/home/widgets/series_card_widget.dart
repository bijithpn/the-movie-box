import 'package:flutter/material.dart';

import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/core/routes/routes.dart';
import 'package:the_movie_box/data/model/movie_model.dart';

import '../../widgets/widgets.dart';

class SeriesCardWidget extends StatelessWidget {
  final List<Show> seriesList;
  final ScrollController? scrollController;
  const SeriesCardWidget({
    super.key,
    required this.seriesList,
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
      itemCount: seriesList.length,
      padding: const EdgeInsets.all(12.0),
      itemBuilder: (context, index) {
        var series = seriesList[index];
        return InkWell(
          onTap: () => Navigator.of(context)
              .pushNamed(Routes.seriesDetail, arguments: series.id),
          child: CachedImageWidget(
              key: ValueKey(series.id),
              fit: BoxFit.cover,
              imageUrl: APIConfig.imageURL + series.posterPath),
        );
      },
    );
  }
}
