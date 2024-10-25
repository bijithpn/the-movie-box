import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:the_movie_box/data/repository/anime_respositroy.dart';
import 'package:the_movie_box/data/repository/series_repository.dart';

import '../../data/model/model.dart';
import '../../data/model/series_details.dart';
import '../../data/repository/movie_repository.dart';
import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    final MovieRepository movieRepository = MovieRepository();
    final SeriesRepository seriesRepository = SeriesRepository();
    final AnimeRepository animeRepository = AnimeRepository();
    final CacheManager cacheManager = CacheManager(
      Config('movieSeriesCache', stalePeriod: const Duration(days: 7)),
    );

    on<GetMovieDetails>((event, emit) async {
      try {
        emit(DetailsLoading());
        final cacheKey = 'movie_${event.moiveId}';
        var cacheFile = await cacheManager.getFileFromCache(cacheKey);
        if (cacheFile != null) {
          try {
            final cachedData = json.decode(await cacheFile.file.readAsString());
            final movieDetails = MovieDetails.fromJson(cachedData['movie']);
            final castList = (cachedData['cast'] as List)
                .map((castMember) =>
                    Cast.fromJson(castMember as Map<String, dynamic>))
                .toList();
            final crewList = (cachedData['crew'] as List)
                .map((crewMember) =>
                    Crew.fromJson(crewMember as Map<String, dynamic>))
                .toList();
            final similarShows = (cachedData['similarMovies'] as List)
                .map((show) => Show.fromJson(show as Map<String, dynamic>))
                .toList();
            final watchProviders = (cachedData['watchProvider'] as List)
                .map((provider) =>
                    Buy.fromJson(provider as Map<String, dynamic>))
                .toList();
            final reviews = (cachedData['reviews'] as List)
                .map((review) =>
                    Reviews.fromJson(review as Map<String, dynamic>))
                .toList();
            final videos = (cachedData['videos'] as List)
                .map((video) => Videos.fromJson(video as Map<String, dynamic>))
                .toList();
            final collection = cachedData['collection'] != null
                ? Collection.fromJson(
                    cachedData['collection'] as Map<String, dynamic>)
                : null;
            final externalIds = ExternalIds.fromJson(
                cachedData['externalIds'] as Map<String, dynamic>);
            emit(MovieDetailsLoaded(
              movie: movieDetails,
              cast: castList,
              crew: crewList,
              similarMovies: similarShows,
              watchProvider: watchProviders,
              reviews: reviews,
              videos: videos,
              externalIds: externalIds,
              collection: collection,
            ));
          } catch (error) {
            // emit(DetailsError(error: error.toString()));
          }
        }
        var result = await Future.wait([
          movieRepository.fetchMovieDetails(event.moiveId),
          movieRepository.fetchMovieCredits(event.moiveId),
          movieRepository.fetchSimilarMovies(event.moiveId),
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
        final cachedData = {
          'movie': (result.first as MovieDetails).toJson(),
          'cast': (result[1] as Map<String, dynamic>)['cast']
              .map((castMember) => (castMember as Cast).toMap())
              .toList(),
          'crew': (result[1] as Map<String, dynamic>)['crew']
              .map((crewMember) => (crewMember as Crew).toJson())
              .toList(),
          'similarMovies': (result[2] as List<Show>)
              .map((similarMovie) => (similarMovie).toJson())
              .toList(),
          'watchProvider': (result[3] as List<Buy>)
              .map((provider) => (provider).toJson())
              .toList(),
          'reviews': (result[4] as List<Reviews>)
              .map((review) => (review).toJson())
              .toList(),
          'videos': (result[5] as List<Videos>)
              .map((video) => (video).toJson())
              .toList(),
          'collection': collection?.toJson(),
          'externalIds': (result[6] as ExternalIds).toJson(),
        };
        await cacheManager.putFile(
            cacheKey, utf8.encode(json.encode(cachedData)));
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
        final cacheKey = 'series_${event.seriesId}';
        var cacheFile = await cacheManager.getFileFromCache(cacheKey);
        if (cacheFile != null) {
          try {
            final cachedData = json.decode(await cacheFile.file.readAsString());
            final seriesDetails = SeriesDetails.fromJson(cachedData['series']);
            final castList = (cachedData['cast'] as List)
                .map((castMember) =>
                    Cast.fromJson(castMember as Map<String, dynamic>))
                .toList();
            final crewList = (cachedData['crew'] as List)
                .map((crewMember) =>
                    Crew.fromJson(crewMember as Map<String, dynamic>))
                .toList();
            final similarShows = (cachedData['similarMovies'] as List)
                .map((show) => Show.fromJson(show as Map<String, dynamic>))
                .toList();
            final watchProviders = (cachedData['watchProvider'] as List)
                .map((provider) =>
                    Buy.fromJson(provider as Map<String, dynamic>))
                .toList();
            final reviews = (cachedData['reviews'] as List)
                .map((review) =>
                    Reviews.fromJson(review as Map<String, dynamic>))
                .toList();
            final videos = (cachedData['videos'] as List)
                .map((video) => Videos.fromJson(video as Map<String, dynamic>))
                .toList();
            final externalIds = ExternalIds.fromJson(
                cachedData['externalIds'] as Map<String, dynamic>);
            emit(SeriesDetailsLoaded(
              series: seriesDetails,
              cast: castList,
              crew: crewList,
              similarMovies: similarShows,
              watchProvider: watchProviders,
              reviews: reviews,
              videos: videos,
              externalIds: externalIds,
            ));
          } catch (error) {
            // emit(DetailsError(error: error.toString()));
          }
        }

        var result = await Future.wait([
          seriesRepository.fetchSeriesDetails(event.seriesId),
          seriesRepository.fetchSeriesCredits(event.seriesId),
          seriesRepository.fetchSimilarSeries(event.seriesId),
          seriesRepository.fetchWhereToWatchSeries(event.seriesId),
          seriesRepository.fetchSeriesReview(event.seriesId),
          seriesRepository.fetchSeriesVideos(event.seriesId),
          seriesRepository.fetchExternalLinkForSeries(event.seriesId),
        ]);

        final cachedData = {
          'series': (result.first as SeriesDetails).toJson(),
          'cast': (result[1] as Map<String, dynamic>)['cast']
              .map((castMember) => (castMember as Cast).toMap())
              .toList(),
          'crew': (result[1] as Map<String, dynamic>)['crew']
              .map((crewMember) => (crewMember as Crew).toJson())
              .toList(),
          'similarMovies': (result[2] as List<Show>)
              .map((similarMovie) => (similarMovie).toJson())
              .toList(),
          'watchProvider': (result[3] as List<Buy>)
              .map((provider) => (provider).toJson())
              .toList(),
          'reviews': (result[4] as List<Reviews>)
              .map((review) => (review).toJson())
              .toList(),
          'videos': (result[5] as List<Videos>)
              .map((video) => (video).toJson())
              .toList(),
          'externalIds': (result[6] as ExternalIds).toJson(),
        };
        await cacheManager.putFile(
            cacheKey, utf8.encode(json.encode(cachedData)));
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
    on<GetAnimeDetails>((event, emit) async {
      try {
        emit(DetailsLoading());
        var cacheKey = 'anime_${event.animeId}';
        var cacheFile = await cacheManager.getFileFromCache(cacheKey);
        if (cacheFile != null) {
          try {
            final cachedData = json.decode(await cacheFile.file.readAsString());
            final animeDetails = AnimeDetails.fromJson(cachedData['anime']);
            emit(AnimeDetailsLoaded(anime: animeDetails));
          } catch (error) {}
        }
        var result = await animeRepository.fetchAnimeDetails(event.animeId);
        final cachedData = {
          'anime': result.toJson(),
        };
        await cacheManager.putFile(
            cacheKey, utf8.encode(json.encode(cachedData)));
        emit(AnimeDetailsLoaded(anime: result));
      } catch (error, stacktrace) {
        debugPrint(stacktrace.toString());
        emit(DetailsError(error: error.toString()));
      }
    });
  }
}
