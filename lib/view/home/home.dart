import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_movie_box/core/routes/routes.dart';
import 'package:the_movie_box/logic/home/home_bloc.dart';
import 'package:the_movie_box/view/home/widgets/anime_card_widget.dart';
import 'package:the_movie_box/view/home/widgets/show_view_builder_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  int moviepageCount = 1, tvSeriesPageCount = 1;

  final ScrollController _animeScrollController = ScrollController();
  final HomeBloc _homeBloc = HomeBloc();
  final ScrollController _moviesScrollController = ScrollController();
  late TabController _tabController;
  final ScrollController _tvSeriesScrollController = ScrollController();

  @override
  void dispose() {
    _tabController.dispose();
    _moviesScrollController.dispose();
    _tvSeriesScrollController.dispose();
    _animeScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _homeBloc.add(GetMovies());
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      if (_tabController.index == 0) {
        _homeBloc.add(GetMovies());
      } else if (_tabController.index == 1) {
        _homeBloc.add(GetTVSeries());
      } else if (_tabController.index == 2) {
        _homeBloc.add(GetAnimes());
      }
    });

    _moviesScrollController.addListener(() {
      if (_moviesScrollController.position.pixels ==
          _moviesScrollController.position.maxScrollExtent) {
        moviepageCount = moviepageCount + 1;
        _homeBloc.add(GetMoreMovies(pageCount: moviepageCount));
      }
    });

    _tvSeriesScrollController.addListener(() {
      if (_tvSeriesScrollController.position.pixels ==
          _tvSeriesScrollController.position.maxScrollExtent) {
        tvSeriesPageCount = tvSeriesPageCount + 1;
        _homeBloc.add(GetMoreTVSeries(pageCount: tvSeriesPageCount));
      }
    });

    _animeScrollController.addListener(() {
      if (_animeScrollController.position.pixels ==
          _animeScrollController.position.maxScrollExtent) {
        _homeBloc.add(const GetMoreAnimes(pageCount: 1));
      }
    });
  }

  Widget _buildTabContent(
      HomeBloc homeBloc, ScrollController scrollController) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeTVSeriesLoaded) {
          return ShowViewBuilder(
            showList: state.tvSeriesList,
            onTap: (id) => context.push(Routes.seriesDetail(id)),
            scrollController: scrollController,
          );
        } else if (state is HomeMoviesLoaded) {
          return ShowViewBuilder(
            showList: state.movieList,
            onTap: (id) => context.push(Routes.movieDetails(id)),
            scrollController: scrollController,
          );
        } else if (state is HomeAnimeLoaded) {
          return AnimeCardWidget(
            animeList: state.animeList,
            scrollController: scrollController,
          );
        } else if (state is HomeError) {
          return Center(
            child: Text(
              state.message ?? "Error",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.red),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _homeBloc,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              Expanded(
                child: Column(children: [
                  DrawerHeader(
                      child: Center(
                    child: Text(
                      "The Movie Box",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  )),
                  ListTile(
                    leading: const Icon(Icons.movie),
                    title: Text(
                      "Trending Movies",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.live_tv),
                    title: Text(
                      "Trending Series",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.watch_later_rounded),
                    title: Text(
                      "Watch list",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.theaters),
                    title: Text(
                      "Watch Providers",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(
                      "Settings",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                    children: const [
                      TextSpan(text: "Made with "),
                      TextSpan(
                        text: "❤️",
                      ),
                      TextSpan(text: " Using "),
                      WidgetSpan(
                        child: FlutterLogo(size: 23),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            "Popular",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  context.push(Routes.search);
                }),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: "Movies"),
              Tab(text: "TV Series"),
              Tab(text: "Anime"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildTabContent(_homeBloc, _moviesScrollController),
            _buildTabContent(_homeBloc, _tvSeriesScrollController),
            _buildTabContent(_homeBloc, _animeScrollController),
          ],
        ),
      ),
    );
  }
}
