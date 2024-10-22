import 'package:flutter/material.dart';

import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/data/model/movie_model.dart';

import '../../widgets/widgets.dart';

class SimilarShowsWidget extends StatelessWidget {
  final List<Show> similarShows;
  final String title;
  final int currentShowId;
  final double? height;
  final Function(int id) onTap;
  const SimilarShowsWidget({
    super.key,
    required this.similarShows,
    this.title = "Similar Movies",
    required this.currentShowId,
    this.height = 190,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return similarShows.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: height,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: similarShows.length,
                    itemBuilder: (_, i) {
                      var show = similarShows[i];
                      return show.id == currentShowId
                          ? const SizedBox.shrink()
                          : InkWell(
                              onTap: () => onTap(show.id),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: CachedImageWidget(
                                    width: 130,
                                    key: ValueKey(show.id),
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        APIConfig.imageURL + show.posterPath),
                              ),
                            );
                    }),
              )
            ],
          );
  }
}
