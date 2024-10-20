import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_box/logic/home/home_bloc.dart';
import 'package:the_movie_box/view/home/widgets/anime_card_widget.dart';
import 'package:the_movie_box/view/home/widgets/movie_card_widget.dart';

import 'widgets/series_card_widget.dart';

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
          return SeriesCardWidget(
            seriesList: state.tvSeriesList,
            scrollController: scrollController,
          );
        } else if (state is HomeMoviesLoaded) {
          return MovieCardWidget(
            movieList: state.movieList,
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
        drawer: const Drawer(),
        appBar: AppBar(
          title: Text(
            "Popular",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {}),],
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
