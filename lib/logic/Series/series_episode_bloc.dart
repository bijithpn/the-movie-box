import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_movie_box/data/model/series_episodes.dart';
import 'package:the_movie_box/data/repository/series_repository.dart';

part 'series_episode_event.dart';
part 'series_episode_state.dart';

class SeriesEpisodeBloc extends Bloc<SeriesEpisodeEvent, SeriesEpisodeState> {
  SeriesEpisodeBloc() : super(SeriesEpisodeInitial()) {
    on<GetSeriesEpisodesDetails>((event, emit) async {
      SeriesRepository seriesRepository = SeriesRepository();
      try {
        emit(EpisodesDetailsLoading());
        var result = await seriesRepository.fetchSeriesEpisodes(
            event.seriesId, event.season);
        emit(SeriesEpisodesLoaded(seriesEpisodes: result));
      } catch (error, stackTrace) {
        print(stackTrace);
        emit(SeriesEpisodeError(error: error.toString()));
      }
    });
  }
}
