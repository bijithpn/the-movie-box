part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<MovieResult> movieList;
  const HomeLoaded(this.movieList);
}

class HomeError extends HomeState {
  final String? message;
  const HomeError(this.message);
}
