import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/logic/details/details_bloc.dart';

import '../widgets/widgets.dart';
import 'widget/widget.dart';

class SeriesDetailsView extends StatefulWidget {
  final int serieId;
  const SeriesDetailsView({
    super.key,
    required this.serieId,
  });

  @override
  State<SeriesDetailsView> createState() => _SeriesDetailsViewState();
}

class _SeriesDetailsViewState extends State<SeriesDetailsView> {
  late DetailsBloc detailsBloc;
  @override
  void initState() {
    detailsBloc = DetailsBloc()..add(GetSeriesDetails(widget.serieId));
    super.initState();
  }

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
          create: (context) => detailsBloc,
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
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7),
                                            child: Text(
                                              series.tagline,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ),
                                        Text(
                                          "Production ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
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
                                        const SizedBox(height: 7),
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
                              Wrap(spacing: 10, runSpacing: 10, children: [
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
                                  SeasonViewBuilder(
                                    detailsBloc: detailsBloc,
                                    seasons: series.seasons,
                                    seriesId: series.id,
                                    seriesName: series.name,
                                  )
                                ],
                              ),
                              SimilarShowsWidget(
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
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
