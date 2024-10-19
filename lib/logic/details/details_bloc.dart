import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/movie_details.dart';
import '../../data/model/series_details.dart';
import '../../data/repository/movie_repository.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    MovieRepository movieRepository = MovieRepository();
    on<GetMovieDetails>((event, emit) async {
      try {
        emit(DetailsLoading());
        var result = await movieRepository.fetchMovieDetails(event.moiveId);
        emit(MovieDetailsLoaded(movie: result));
      } catch (error) {
        emit(DetailsError(error: error.toString()));
      }
    });
    on<GetSeriesDetails>((event, emit) async {
      try {
        emit(DetailsLoading());
        var result = await movieRepository.fetchSeriesDetails(event.seriesId);
        emit(SeriesDetailsLoaded(series: result));
      } catch (error) {
        emit(DetailsError(error: error.toString()));
      }
    });
  }
}
