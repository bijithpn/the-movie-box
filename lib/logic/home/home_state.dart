part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeMoviesLoaded extends HomeState {
  final List<Show> movieList;

  const HomeMoviesLoaded({required this.movieList});

  @override
  List<Object> get props => [movieList];
}

class HomeTVSeriesLoaded extends HomeState {
  final List<Show> tvSeriesList;

  const HomeTVSeriesLoaded({required this.tvSeriesList});

  @override
  List<Object> get props => [tvSeriesList];
}

class HomeAnimeLoaded extends HomeState {
  final List<Anime> animeList;

  const HomeAnimeLoaded({required this.animeList});

  @override
  List<Object> get props => [animeList];
}

class HomeError extends HomeState {
  final String? message;
  const HomeError({required this.message});
}
