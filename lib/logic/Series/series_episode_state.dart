part of 'series_episode_bloc.dart';

sealed class SeriesEpisodeState extends Equatable {
  const SeriesEpisodeState();

  @override
  List<Object> get props => [];
}

final class SeriesEpisodeInitial extends SeriesEpisodeState {}

final class EpisodesDetailsLoading extends SeriesEpisodeState {}

final class SeriesEpisodesLoaded extends SeriesEpisodeState {
  final SeriesEpisodes seriesEpisodes;
  const SeriesEpisodesLoaded({
    required this.seriesEpisodes,
  });
}

final class SeriesEpisodeError extends SeriesEpisodeState {
  final String error;
  const SeriesEpisodeError({
    required this.error,
  });
}
