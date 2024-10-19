part of 'details_bloc.dart';

sealed class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

final class DetailsInitial extends DetailsState {}

final class DetailsLoading extends DetailsState {}

final class MovieDetailsLoaded extends DetailsState {
  final MovieDetails movie;
  const MovieDetailsLoaded({required this.movie});
}

final class SeriesDetailsLoaded extends DetailsState {
  final SeriesDetails series;
  const SeriesDetailsLoaded({required this.series});
}

final class DetailsError extends DetailsState {
  final String error;
  const DetailsError({required this.error});
}
