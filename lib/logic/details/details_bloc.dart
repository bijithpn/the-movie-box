import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/movie_details.dart';
import '../../data/repository/movie_repository.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    MovieRepository movieRepository = MovieRepository();
    on<GetMovieDetails>((event, emit) async {
      try {
        emit(DetailsLoading());
        var result = await movieRepository.getMovieDetails(event.moiveId);
        emit(DetailsLoaded(movie: result));
      } catch (error) {
        emit(DetailsError(error: error.toString()));
      }
    });
  }
}
