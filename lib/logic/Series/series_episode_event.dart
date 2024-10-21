part of 'series_episode_bloc.dart';

sealed class SeriesEpisodeEvent extends Equatable {
  const SeriesEpisodeEvent();

  @override
  List<Object> get props => [];
}

class GetSeriesEpisodesDetails extends SeriesEpisodeEvent {
  final int seriesId;
  final int season;
  const GetSeriesEpisodesDetails({
    required this.seriesId,
    required this.season,
  });
}
