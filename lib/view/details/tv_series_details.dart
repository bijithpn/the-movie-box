import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/core/routes/routes.dart';
import 'package:the_movie_box/logic/details/details_bloc.dart';
import 'package:the_movie_box/utils/utils.dart';

import '../widgets/widgets.dart';
import 'widget/widget.dart';

class SeriesDetailsView extends StatelessWidget {
  final int serieId;
  const SeriesDetailsView({
    super.key,
    required this.serieId,
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
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => context.pop(context),
                icon: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.6),
                        shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_back, size: 20))),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Utils.deeplinkCreater(
                      route: 'seriesdetails', showId: serieId);
                },
                icon: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.6),
                        shape: BoxShape.circle),
                    child: const Icon(Icons.share, size: 20))),
            // IconButton(
            //     padding: EdgeInsets.zero,
            //     onPressed: () {},
            //     icon: Container(
            //         alignment: Alignment.center,
            //         padding: const EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //             color: Colors.black.withOpacity(.6),
            //             shape: BoxShape.circle),
            //         child: const Icon(Icons.bookmark_add_outlined, size: 20))),
          ],
        ),
        body: BlocProvider(
          create: (context) => DetailsBloc()..add(GetSeriesDetails(serieId)),
          child: BlocBuilder<DetailsBloc, DetailsState>(
            builder: (context, state) {
              if (state is DetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is SeriesDetailsLoaded) {
                var series = state.series;
                return SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainImageView(
                          title: series.name,
                          imageurl: APIConfig.imageURL + series.backdropPath,
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
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          series.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        if (series.tagline.isNotEmpty)
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                series.tagline,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              )),
                                        if (series
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
                                                  series.productionCompanies
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(series.firstAirDate.year
                                                .toString()),
                                            if (series
                                                .episodeRunTime.isNotEmpty)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                    "AVG runtime: ${series.episodeRunTime.first} min"),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  CachedImageWidget(
                                    width: 120,
                                    height: 140,
                                    imageUrl:
                                        APIConfig.imageURL + series.posterPath,
                                  )
                                ],
                              ),
                              const SizedBox(height: 7),
                              Wrap(spacing: 10, children: [
                                ...series.genres.map((e) => Chip(
                                        label: Text(
                                      e.name,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ))),
                              ]),
                              if (series.overview.isNotEmpty)
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
                                      series.overview,
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
                                  if (series.seasons.isNotEmpty)
                                    const Tab(
                                      text: "Seasons",
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
                                        )
                                      ],
                                    ),
                                  if (series.seasons.isNotEmpty)
                                    SeasonViewBuilder(
                                      seasons: series.seasons,
                                      seriesId: series.id,
                                      seriesName: series.name,
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
                              ExternalLinkWidget(
                                externalIds: state.externalIds,
                              ),
                              SimilarShowsWidget(
                                currentShowId: series.id,
                                onTap: (id) =>
                                    context.push(Routes.seriesDetail(id)),
                                title: "Similar Series",
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
              return const Center(
                  child: Text("Something went wrong please try again later"));
            },
          ),
        ),
      ),
    );
  }
}
