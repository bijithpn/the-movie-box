import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_box/core/client/api_client.dart';
import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/logic/details/details_bloc.dart';

import 'widget/scrollable_tabbar.dart';

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
                        CachedNetworkImage(
                          height: 250,
                          fit: BoxFit.cover,
                          placeholder: (_, __) =>
                              const Center(child: CircularProgressIndicator()),
                          imageUrl: APIConfig.imageURL + movie.backdropPath,
                          imageBuilder: (_, imageProvider) => Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 270,
                                clipBehavior: Clip.none,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              // Gradient overlay for fading effect
                              Positioned.fill(
                                child: Container(
                                  height: 270,
                                  clipBehavior: Clip.none,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors
                                            .transparent, // Start with transparent
                                        Theme.of(context)
                                            .scaffoldBackgroundColor
                                            .withOpacity(0.3),
                                        Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ],
                                      begin: Alignment.center,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
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
                                      const SizedBox(height: 7),
                                      SizedBox(
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
                                      const SizedBox(height: 7),
                                      Text(
                                        "Production ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                      const SizedBox(height: 7),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(movie.releaseDate.year
                                              .toString()),
                                          const SizedBox(width: 10),
                                          Text("${movie.runtime} min"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  CachedNetworkImage(
                                    width: 120,
                                    height: 140,
                                    placeholder: (context, url) => Container(
                                        width: 120,
                                        height: 140,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade400,
                                              width: 1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: const Center(
                                            child:
                                                CircularProgressIndicator())),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                            width: 120,
                                            height: 140,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade400,
                                                  width: 1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                            ),
                                            child: const Center(
                                                child: Icon(Icons.error))),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                            width: 120,
                                            height: 140,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade400,
                                                  width: 1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                    imageUrl:
                                        APIConfig.imageURL + movie.posterPath,
                                  )
                                ],
                              ),
                              const SizedBox(height: 7),
                              Wrap(spacing: 10, runSpacing: 10, children: [
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
                                ],
                                children: [
                                  if (state.crew.isNotEmpty &&
                                      state.crew.isNotEmpty)
                                    Column(
                                      children: [
                                        if (state.cast.isNotEmpty)
                                          SizedBox(
                                            height: 170,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: state.cast.length,
                                                padding: const EdgeInsets.only(
                                                    top: 15, left: 5),
                                                itemBuilder: (_, i) {
                                                  var cast = state.cast[i];
                                                  return Container(
                                                    width: 130,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Column(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 35,
                                                          backgroundImage:
                                                              CachedNetworkImageProvider(
                                                                  APIConfig
                                                                          .imageURL +
                                                                      cast.profilePath),
                                                        ),
                                                        const SizedBox(
                                                            height: 9),
                                                        Text(
                                                          cast.name,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                          cast.character,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        if (state.crew.isNotEmpty)
                                          SizedBox(
                                            height: 170,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: state.crew.length,
                                                padding: const EdgeInsets.only(
                                                    top: 15, left: 5),
                                                itemBuilder: (_, i) {
                                                  var crew = state.crew[i];
                                                  return Container(
                                                    width: 130,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Column(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 35,
                                                          backgroundImage:
                                                              CachedNetworkImageProvider(
                                                                  APIConfig
                                                                          .imageURL +
                                                                      crew.profilePath),
                                                        ),
                                                        const SizedBox(
                                                            height: 9),
                                                        Text(
                                                          crew.name,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                          crew.job,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          )
                                      ],
                                    ),
                                  if (state.watchProvider.isNotEmpty)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Buy",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            itemCount:
                                                state.watchProvider.length,
                                            itemBuilder: (_, i) {
                                              var buyer =
                                                  state.watchProvider[i];
                                              return ListTile(
                                                leading: CachedNetworkImage(
                                                  imageUrl: APIConfig.imageURL +
                                                      buyer.logoPath,
                                                  placeholder: (context, url) =>
                                                      Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400,
                                                                width: 1),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          child: const Center(
                                                              child:
                                                                  CircularProgressIndicator())),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400,
                                                                width: 1),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          child: const Center(
                                                              child: Icon(Icons
                                                                  .error))),
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400,
                                                                width: 1),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )),
                                                ),
                                                title: Text(
                                                  buyer.providerName,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              );
                                            }),
                                      ],
                                    )
                                ],
                              ),
                              if (state.similarMovies.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Similar Movies",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 180,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.similarMovies.length,
                                          itemBuilder: (_, i) {
                                            var movie = state.similarMovies[i];
                                            return InkWell(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: CachedNetworkImage(
                                                    width: 100,
                                                    key: ValueKey(movie.id),
                                                    fit: BoxFit.cover,
                                                    placeholder: (context, url) =>
                                                        Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400,
                                                                  width: 1),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          10)),
                                                            ),
                                                            child: const Center(
                                                                child:
                                                                    CircularProgressIndicator())),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400,
                                                                  width: 1),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          10)),
                                                            ),
                                                            child: const Center(
                                                                child: Icon(Icons
                                                                    .error))),
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                            decoration:
                                                                BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade400,
                                                              width: 1),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )),
                                                    imageUrl:
                                                        APIConfig.imageURL +
                                                            movie.posterPath),
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                ),
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
