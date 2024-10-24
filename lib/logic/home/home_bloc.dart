import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_movie_box/data/model/anime_model.dart';
import 'package:the_movie_box/data/model/movie_model.dart';
import 'package:the_movie_box/data/repository/anime_respositroy.dart';
import 'package:the_movie_box/data/repository/movie_repository.dart';
import 'package:the_movie_box/data/repository/series_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepository movieRepository;
  final SeriesRepository seriesRepository;
  final AnimeRepository animeRepository;

  List<Show> _currentMovies = [];
  List<Show> _currentTVSeries = [];
  List<Anime> _currentAnimes = [];

  HomeBloc({
    required this.movieRepository,
    required this.seriesRepository,
    required this.animeRepository,
  }) : super(HomeInitial()) {
    on<GetMovies>((event, emit) async {
      if (_currentMovies.isNotEmpty) {
        emit(HomeMoviesLoaded(movieList: _currentMovies));
        return;
      }
      try {
        emit(HomeLoading());
        final mList = await movieRepository.fetchMovieResults();
        _currentMovies = mList;
        emit(HomeMoviesLoaded(movieList: mList));
      } catch (error) {
        emit(HomeError(message: error.toString()));
      }
    });

    on<GetMoreMovies>((event, emit) async {
      if (state is HomeMoviesLoaded) {
        try {
          final currentMovies = (state as HomeMoviesLoaded).movieList;
          final newMovies =
              await movieRepository.fetchMovieResults(page: event.pageCount);
          _currentMovies = currentMovies + newMovies;
          emit(HomeMoviesLoaded(movieList: _currentMovies));
        } catch (e) {
          emit(const HomeError(message: "Error loading more movies"));
        }
      }
    });

    on<GetTVSeries>((event, emit) async {
      if (_currentTVSeries.isNotEmpty) {
        emit(HomeTVSeriesLoaded(tvSeriesList: _currentTVSeries));
        return;
      }
      try {
        emit(HomeLoading());
        final tvSeries = await seriesRepository.fetchTVSeriesResults();
        _currentTVSeries = tvSeries;
        emit(HomeTVSeriesLoaded(tvSeriesList: tvSeries));
      } catch (e) {
        emit(const HomeError(message: "Error loading TV series"));
      }
    });

    on<GetMoreTVSeries>((event, emit) async {
      if (state is HomeTVSeriesLoaded) {
        try {
          final currentTVSeries = (state as HomeTVSeriesLoaded).tvSeriesList;
          final newTVSeries = await seriesRepository.fetchTVSeriesResults(
              page: event.pageCount);
          _currentTVSeries = currentTVSeries + newTVSeries;
          emit(HomeTVSeriesLoaded(tvSeriesList: _currentTVSeries));
        } catch (e) {
          emit(const HomeError(message: "Error loading more TV series"));
        }
      }
    });

    on<GetAnimes>((event, emit) async {
      if (_currentAnimes.isNotEmpty) {
        emit(HomeAnimeLoaded(animeList: _currentAnimes));
        return;
      }
      try {
        emit(HomeLoading());
        final anime = await animeRepository.fetchAnime();
        _currentAnimes = anime;
        emit(HomeAnimeLoaded(animeList: anime));
      } catch (e) {
        emit(const HomeError(message: "Error loading anime"));
      }
    });

    on<GetMoreAnimes>((event, emit) async {
      if (state is HomeAnimeLoaded) {
        try {
          final currentAnime = (state as HomeAnimeLoaded).animeList;
          final newAnime =
              await animeRepository.fetchAnime(page: event.pageCount);
          _currentAnimes = currentAnime + newAnime;
          emit(HomeAnimeLoaded(animeList: _currentAnimes));
        } catch (e) {
          emit(const HomeError(message: "Error loading more anime"));
        }
      }
    });
  }
}
