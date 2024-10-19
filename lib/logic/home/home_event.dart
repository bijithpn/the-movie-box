part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class GetMovies extends HomeEvent {}

class GetMoreMovies extends HomeEvent {
  final int pageCount;
  const GetMoreMovies({required this.pageCount});
}

class GetTVSeries extends HomeEvent {}

class GetMoreTVSeries extends HomeEvent {
  final int pageCount;
  const GetMoreTVSeries({required this.pageCount});
}

class GetAnimes extends HomeEvent {}

class GetMoreAnimes extends HomeEvent {
  final int pageCount;
  const GetMoreAnimes({required this.pageCount});
}
