import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:the_movie_box/data/model/cast_and_crew_model.dart';
import 'package:the_movie_box/data/model/collection_model.dart';
import 'package:the_movie_box/data/model/external_id_model.dart';
import 'package:the_movie_box/data/model/movie_model.dart';
import 'package:the_movie_box/data/model/platform_model.dart';
import 'package:the_movie_box/data/model/review_model.dart';
import 'package:the_movie_box/data/model/video_model.dart';
import 'package:the_movie_box/data/repository/series_repository.dart';

import '../../data/model/movie_details.dart';
import '../../data/model/series_details.dart';
import '../../data/repository/movie_repository.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    MovieRepository movieRepository = MovieRepository();
    SeriesRepository seriesRepository = SeriesRepository();
    on<GetMovieDetails>((event, emit) async {
      try {
        emit(DetailsLoading());
        var result = await Future.wait([
          movieRepository.fetchMovieDetails(event.moiveId),
          movieRepository.fetchMovieCredits(event.moiveId),
          movieRepository.fetchSimilarMovie(event.moiveId),
          movieRepository.fetchWhereToWatchMovie(event.moiveId),
          movieRepository.fetchMoviesReview(event.moiveId),
          movieRepository.fetchMoviesVideos(event.moiveId),
          movieRepository.fetchExternalLinkForMovies(event.moiveId),
        ]);
        Collection? collection;
        if ((result.first as MovieDetails).belongsToCollection != null) {
          collection = await movieRepository.fetchCollectionOfMovies(
              (result.first as MovieDetails).belongsToCollection!.id);
        }
        emit(MovieDetailsLoaded(
            movie: result.first as MovieDetails,
            cast: (result[1] as Map<String, dynamic>)['cast'] as List<Cast>,
            crew: (result[1] as Map<String, dynamic>)['crew'] as List<Crew>,
            similarMovies: result[2] as List<Show>,
            watchProvider: result[3] as List<Buy>,
            reviews: result[4] as List<Reviews>,
            collection: collection,
            videos: result[5] as List<Videos>,
            externalIds: result[6] as ExternalIds));
      } catch (error, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(DetailsError(error: error.toString()));
      }
    });
    on<GetSeriesDetails>((event, emit) async {
      try {
        emit(DetailsLoading());
        var result = await Future.wait([
          seriesRepository.fetchSeriesDetails(event.seriesId),
          seriesRepository.fetchSeriesCredits(event.seriesId),
          seriesRepository.fetchSimilarSeries(event.seriesId),
          seriesRepository.fetchWhereToWatchSeries(event.seriesId),
          seriesRepository.fetchSeriesReview(event.seriesId),
          seriesRepository.fetchSeriesVideos(event.seriesId),
          seriesRepository.fetchExternalLinkForSeries(event.seriesId),
        ]);

        emit(SeriesDetailsLoaded(
          series: result.first as SeriesDetails,
          cast: (result[1] as Map<String, dynamic>)['cast'] as List<Cast>,
          crew: (result[1] as Map<String, dynamic>)['crew'] as List<Crew>,
          similarMovies: result[2] as List<Show>,
          watchProvider: result[3] as List<Buy>,
          reviews: result[4] as List<Reviews>,
          externalIds: result[6] as ExternalIds,
          videos: result[5] as List<Videos>,
        ));
      } catch (error, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(DetailsError(error: error.toString()));
      }
    });
  }
}
