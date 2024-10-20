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
          child: CachedNetworkImage(
              key: ValueKey(series.id),
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
              imageUrl: APIConfig.imageURL + series.posterPath),
        );
      },
    );
  }
}
