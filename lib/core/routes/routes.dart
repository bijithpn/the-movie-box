import 'package:flutter/material.dart';
import '../../view/view.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.movieDetails:
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => MovieDetailsView(
              key: ValueKey(args),
              movieId: args,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => const ErrorScreen(
              errorMessage: 'Invalid arguments for movie details'),
        );
      case Routes.seriesDetail:
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => SeriesDetailsView(
              key: ValueKey(args),
              serieId: args,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => const ErrorScreen(
              errorMessage: 'Invalid arguments for series details'),
        );
      case Routes.search:
        return MaterialPageRoute(
          builder: (_) => const SearchPage(),
        );
      case Routes.episodeDetails:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => SeriesEpisodeView(
              detailsBloc: args['detailsBloc'],
              seasonCount: args['seasonCount'],
              seriesName: args['seriesName'],
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => const ErrorScreen(
              errorMessage: 'Invalid arguments for episode details'),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              ErrorScreen(errorMessage: 'Route not found: ${settings.name}'),
        );
    }
  }
}

class Routes {
  static const String movieDetails = '/moviedetails';
  static const String seriesDetail = '/seriesDetail';
  static const String episodeDetails = '/episodeDetails';
  static const String home = '/';
  static const String search = '/search';
}
