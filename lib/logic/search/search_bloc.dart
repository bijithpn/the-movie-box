import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:the_movie_box/data/model/movie_model.dart';
import 'package:the_movie_box/data/repository/movie_repository.dart';
import 'package:the_movie_box/data/repository/series_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    final MovieRepository movieRepository = MovieRepository();
    final SeriesRepository seriesRepository = SeriesRepository();
    on<SearchMovieEvent>((event, emit) async {
      try {
        emit(SearchLoadingState());
        final serachResult = await movieRepository.searchMovies(event.query);
        emit(SearchLoadedState(serachResult));
      } catch (error) {
        emit(SearchErrorState(error.toString()));
      }
    });
    on<SearchTvEvent>((event, emit) async {
      try {
        emit(SearchLoadingState());
        final serachResult = await seriesRepository.searchSeries(event.query);
        emit(SearchLoadedState(serachResult));
      } catch (error) {
        emit(SearchErrorState(error.toString()));
      }
    });
  }
}
