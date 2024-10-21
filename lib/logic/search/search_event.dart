part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchMovieEvent extends SearchEvent {
  final String query;

  const SearchMovieEvent(this.query);

  @override
  List<Object> get props => [query];
}

class SearchTvEvent extends SearchEvent {
  final String query;

  const SearchTvEvent(this.query);

  @override
  List<Object> get props => [query];
}
