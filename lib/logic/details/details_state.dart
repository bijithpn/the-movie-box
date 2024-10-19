part of 'details_bloc.dart';

sealed class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

final class DetailsInitial extends DetailsState {}

final class DetailsLoading extends DetailsState {}

final class DetailsLoaded extends DetailsState {
  final MovieDetails movie;
  const DetailsLoaded({required this.movie});
}

final class DetailsError extends DetailsState {
  final String error;
  const DetailsError({required this.error});
}
