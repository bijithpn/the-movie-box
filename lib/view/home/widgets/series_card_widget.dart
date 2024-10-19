import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/data/model/movie_model.dart';
import 'package:the_movie_box/view/details/tv_series_details.dart';

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
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SeriesDetailsView(
                          serieId: series.id,
                        )));
          },
          child: Card(
            elevation: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  imageUrl: APIConfig.imageURL + series.posterPath),
            ),
          ),
        );
      },
    );
  }
}
