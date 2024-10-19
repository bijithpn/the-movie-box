part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class GetMovieDetails extends DetailsEvent {
  final int moiveId;
  const GetMovieDetails(this.moiveId);
}
