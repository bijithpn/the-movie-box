import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/logic/details/details_bloc.dart';

class SeriesDetailsView extends StatelessWidget {
  final int serieId;
  const SeriesDetailsView({
    super.key,
    required this.serieId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: BlocProvider(
        create: (context) => DetailsBloc()..add(GetSeriesDetails(serieId)),
        child: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            if (state is DetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SeriesDetailsLoaded) {
              var movie = state.series;
              return Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    CachedNetworkImage(
                      placeholder: (_, __) =>
                          const Center(child: CircularProgressIndicator()),
                      imageUrl: APIConfig.imageURL + movie.backdropPath,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      movie.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  ]));
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
