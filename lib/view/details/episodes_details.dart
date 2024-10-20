import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/logic/details/details_bloc.dart';

class SeriesEpisodeView extends StatelessWidget {
  final DetailsBloc detailsBloc;
  final int seasonCount;
  final String seriesName;
  const SeriesEpisodeView({
    super.key,
    required this.detailsBloc,
    required this.seasonCount,
    required this.seriesName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: detailsBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Season $seasonCount"),
        ),
        body: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            if (state is DetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SeriesEpisodesLoaded) {
              var series = state.seriesEpisodes;
              return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                            height: 170,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => const Center(
                                child: CircularProgressIndicator()),
                            imageUrl:
                                "${APIConfig.imageURL}${series.posterPath}",
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(seriesName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              if (series.overview.isNotEmpty)
                                Text(
                                  series.overview,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                              Text(
                                  "Relase Date: ${DateFormat("dd MMM yyyy").format(series.airDate)}"),
                            ],
                          ))
                        ],
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: series.episodes.length,
                          itemBuilder: (_, i) {
                            var episode = series.episodes[i];
                            return ListTile(
                              leading: Container(
                                width: 80,
                                height: 100,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade400),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            APIConfig.imageURL +
                                                (episode.stillPath)))),
                              ),
                              title: Text(
                                "${episode.episodeNumber}. ${episode.name}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                episode.overview,
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Text(episode.voteAverage.toString()),
                            );
                          }),
                    ]),
              );
            }
            if (state is DetailsError) {
              return Center(child: Text(state.error));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
