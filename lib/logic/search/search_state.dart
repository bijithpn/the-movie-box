part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitialState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadingState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadedState extends SearchState {
  final List<Show> results;

  const SearchLoadedState(this.results);

  @override
  List<Object> get props => [results];
}

class SearchErrorState extends SearchState {
  final String error;

  const SearchErrorState(this.error);

  @override
  List<Object> get props => [error];
}
