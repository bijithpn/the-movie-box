import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/logic/details/details_bloc.dart';

class MovieDetailsView extends StatelessWidget {
  final int moiveId;
  const MovieDetailsView({
    super.key,
    required this.moiveId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: BlocProvider(
        create: (context) => DetailsBloc()..add(GetMovieDetails(moiveId)),
        child: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            if (state is DetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MovieDetailsLoaded) {
              var movie = state.movie;
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
                      movie.title,
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
