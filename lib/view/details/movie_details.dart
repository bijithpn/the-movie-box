import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/core/routes/routes.dart';
import 'package:the_movie_box/logic/details/details_bloc.dart';
import 'package:the_movie_box/view/details/widget/widget.dart';

import '../widgets/widgets.dart';

class MovieDetailsView extends StatelessWidget {
  final int movieId;
  const MovieDetailsView({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: BlocProvider(
          create: (context) => DetailsBloc()..add(GetMovieDetails(movieId)),
          child: BlocBuilder<DetailsBloc, DetailsState>(
            builder: (context, state) {
              if (state is DetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is MovieDetailsLoaded) {
                var movie = state.movie;
                return SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainImageView(
                            imageurl: APIConfig.imageURL + movie.backdropPath),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        if (movie.tagline.isNotEmpty)
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                movie.tagline,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              )),
                                        if (movie
                                            .productionCompanies.isNotEmpty)
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Production ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 2, bottom: 7),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Text(
                                                  movie.productionCompanies
                                                      .map((e) => e.name)
                                                      .join(', '),
                                                  maxLines: 4,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                        height: 1.5,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        Row(
                                          children: [
                                            Text(movie.releaseDate.year
                                                .toString()),
                                            const SizedBox(width: 10),
                                            Text("${movie.runtime} min"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  CachedImageWidget(
                                    width: 120,
                                    height: 140,
                                    imageUrl:
                                        APIConfig.imageURL + movie.posterPath,
                                  )
                                ],
                              ),
                              Wrap(spacing: 10, children: [
                                ...movie.genres.map((e) => Chip(
                                        label: Text(
                                      e.name,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ))),
                              ]),
                              if (movie.overview.isNotEmpty)
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 7),
                                      width: double.infinity,
                                      height: 1,
                                      color: Colors.grey.shade400,
                                    ),
                                    Text(
                                      movie.overview,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 7),
                                      width: double.infinity,
                                      height: 1,
                                      color: Colors.grey.shade400,
                                    ),
                                  ],
                                ),
                              ScrollableTab(
                                isScrollable: true,
                                tabAlignment: TabAlignment.start,
                                tabs: [
                                  if (state.crew.isNotEmpty &&
                                      state.crew.isNotEmpty)
                                    const Tab(
                                      text: "CAST + CREW",
                                    ),
                                  if (state.watchProvider.isNotEmpty)
                                    const Tab(
                                      text: "WHERE TO WATCH",
                                    ),
                                  if (state.reviews.isNotEmpty)
                                    const Tab(
                                      text: "REVIEWS",
                                    ),
                                  if (state.videos.isNotEmpty)
                                    const Tab(
                                      text: "VIDEOS",
                                    ),
                                ],
                                children: [
                                  if (state.crew.isNotEmpty &&
                                      state.crew.isNotEmpty)
                                    Column(
                                      children: [
                                        CastWidget(
                                          castList: state.cast,
                                        ),
                                        CrewWidget(
                                          crewList: state.crew,
                                        ),
                                      ],
                                    ),
                                  if (state.watchProvider.isNotEmpty)
                                    WatchProviderWidget(
                                      watchProvider: state.watchProvider,
                                    ),
                                  if (state.reviews.isNotEmpty)
                                    ReviewWidget(reviews: state.reviews),
                                  if (state.videos.isNotEmpty)
                                    VideosWidget(videos: state.videos),
                                ],
                              ),
                              if (state.collection != null &&
                                  state.collection!.shows.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: SimilarShowsWidget(
                                    onTap: (id) => Navigator.of(context)
                                        .pushNamed(Routes.movieDetails,
                                            arguments: id),
                                    title: "Related Movies",
                                    similarShows: state.collection!.shows,
                                    currentShowId: movieId,
                                  ),
                                ),
                              SimilarShowsWidget(
                                currentShowId: movieId,
                                onTap: (id) => Navigator.of(context).pushNamed(
                                    Routes.movieDetails,
                                    arguments: id),
                                similarShows: state.similarMovies,
                              )
                            ],
                          ),
                        ),
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
      ),
    );
  }
}
