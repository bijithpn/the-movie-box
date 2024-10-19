import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_movie_box/data/model/movie_model.dart';
import 'package:the_movie_box/data/repository/movie_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    final MovieRepository movieRepository = MovieRepository();
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
        final tvSeries = await movieRepository.fetchTVSeriesResults();
        emit(HomeTVSeriesLoaded(tvSeriesList: tvSeries));
      } catch (e) {
        emit(const HomeError(message: "Error loading TV series"));
      }
    });

    on<GetMoreTVSeries>((event, emit) async {
      if (state is HomeTVSeriesLoaded) {
        try {
          final currentTVSeries = (state as HomeTVSeriesLoaded).tvSeriesList;
          final newTVSeries =
              await movieRepository.fetchTVSeriesResults(page: event.pageCount);
          emit(HomeTVSeriesLoaded(tvSeriesList: currentTVSeries + newTVSeries));
        } catch (e) {
          emit(const HomeError(message: "Error loading more TV series"));
        }
      }
    });

    // on<GetAnimes>((event, emit) async {
    //   try {
    //     final anime = await fetchAnime();
    //     emit(HomeLoaded(movieList: anime));
    //   } catch (e) {
    //     emit(const HomeError(message: "Error loading anime"));
    //   }
    // });

    // on<GetMoreAnimes>((event, emit) async {
    //   if (state is HomeLoaded) {
    //     try {
    //       final currentAnime = (state as HomeLoaded).movieList;
    //       final newAnime = await fetchMoreAnime();
    //       emit(HomeLoaded(movieList: currentAnime + newAnime));
    //     } catch (e) {
    //       emit(const HomeError(message: "Error loading more anime"));
    //     }
    //   }
    // });
  }
}
