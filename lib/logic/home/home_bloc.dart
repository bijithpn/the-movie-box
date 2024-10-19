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
        final mList = await movieRepository.getMovieResults();
        emit(HomeLoaded(mList));
      } catch (error) {
        emit(HomeError(error.toString()));
      }
    });
  }
}
