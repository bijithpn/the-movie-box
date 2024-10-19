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
  HomeBloc() : super(HomeInitial()) {
    final MovieRepository movieRepository = MovieRepository();
    final SeriesRepository seriesRepository = SeriesRepository();
    final AnimeRespositroy animeRespositroy = AnimeRespositroy();

    on<GetMovies>((event, emit) async {
      try {
        emit(HomeLoading());
        final mList = await movieRepository.fetchMovieResults();
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
          emit(HomeMoviesLoaded(movieList: currentMovies + newMovies));
        } catch (e) {
          emit(const HomeError(message: "Error loading more movies"));
        }
      }
    });

    on<GetTVSeries>((event, emit) async {
      try {
        final tvSeries = await seriesRepository.fetchTVSeriesResults();
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
          emit(HomeTVSeriesLoaded(tvSeriesList: currentTVSeries + newTVSeries));
        } catch (e) {
          emit(const HomeError(message: "Error loading more TV series"));
        }
      }
    });

    on<GetAnimes>((event, emit) async {
      try {
        final anime = await animeRespositroy.fetchAnime();
        emit(HomeAnimeLoaded(animeList: anime));
      } catch (e) {
        emit(const HomeError(message: "Error loading anime"));
      }
    });

    // on<GetMoreAnimes>((event, emit) async {
    //   if (state is HomeAnimeLoaded) {
    //     try {
    //       final currentAnime = (state as HomeAnimeLoaded).animeList;
    //       final newAnime =
    //           await animeRespositroy.fetchAnime(page: event.pageCount);
    //       emit(HomeAnimeLoaded(animeList: currentAnime + newAnime));
    //     } catch (e) {
    //       emit(const HomeError(message: "Error loading more anime"));
    //     }
    //   }
    // });
  }
}
