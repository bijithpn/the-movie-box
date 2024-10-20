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

class GetSeriesDetails extends DetailsEvent {
  final int seriesId;
  const GetSeriesDetails(this.seriesId);
}

class GetSeriesEpisodesDetails extends DetailsEvent {
  final int seriesId;
  final int season;
  const GetSeriesEpisodesDetails({
    required this.seriesId,
    required this.season,
  });
}
