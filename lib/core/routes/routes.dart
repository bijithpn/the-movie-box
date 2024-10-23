import 'package:flutter/material.dart';
import 'package:the_movie_box/utils/utils.dart';
import '../../view/view.dart';

import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final GoRouter _router;
  late AppLinks _appLinks;

  AppRouter()
      : _router = GoRouter(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) => const HomeView(),
            ),
            GoRoute(
              name: "movieDetails",
              path: "/moviedetails/:id",
              builder: (context, state) {
                final movieId = int.tryParse(state.pathParameters['id'] ?? '');
                if (movieId != null) {
                  return MovieDetailsView(
                    key: ValueKey(movieId),
                    movieId: movieId,
                  );
                }
                return const ErrorScreen(
                    errorMessage: 'Invalid arguments for movie details');
              },
            ),
            GoRoute(
              name: "seriesDetails",
              path: "/seriesDetails/:id",
              builder: (context, state) {
                final seriesId = int.tryParse(state.pathParameters['id'] ?? '');
                if (seriesId != null) {
                  return SeriesDetailsView(
                    key: ValueKey(seriesId),
                    serieId: seriesId,
                  );
                }
                return const ErrorScreen(
                    errorMessage: 'Invalid arguments for series details');
              },
            ),
            GoRoute(
              name: "episodeDetails",
              path: Routes.episodeDetails,
              builder: (context, state) {
                final args = state.extra as Map<String, dynamic>?;
                if (args != null &&
                    args.containsKey('seriesId') &&
                    args.containsKey('seasonCount') &&
                    args.containsKey('seriesName')) {
                  return SeriesEpisodeView(
                    seriesId: args['seriesId'],
                    seasonCount: args['seasonCount'],
                    seriesName: args['seriesName'],
                  );
                }
                return const ErrorScreen(
                    errorMessage: 'Invalid arguments for episode details');
              },
            ),
            GoRoute(
              name: "search",
              path: Routes.search,
              builder: (context, state) => const SearchPage(),
            ),
          ],
          errorBuilder: (context, state) => ErrorScreen(
            errorMessage: 'Route not found: ${state.uri.toString()}',
          ),
        ) {
    _appLinks = AppLinks();
    initDeepLinkListener();
  }

  GoRouter get router => _router;

  /// Initialize the deep link listener.
  void initDeepLinkListener() {
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        final deepLink = uri.toString();
        debugPrint('Received deep link: $deepLink');
        _handleDeepLink(deepLink);
      }
    });
  }

  /// Handle deep links and navigate to the appropriate page.
  void _handleDeepLink(String deepLink) {
    try {
      final uri = Uri.parse(deepLink);
      final location = Utils.base64Decode(uri.pathSegments.first);
      final id = Utils.base64Decode(uri.pathSegments.last);
      if (uri.pathSegments.isNotEmpty) {
        _router.go('/');
        _router.push('/$location/$id');
      } else {
        debugPrint('Unknown deep link: $deepLink');
        _router.go('/');
      }
    } catch (error) {
      print(error);
    }
  }
}

class Routes {
  static String movieDetails(int movieId) {
    return "/moviedetails/$movieId";
  }

  static String seriesDetail(int seriesId) {
    return "/seriesDetails/$seriesId";
  }

  static const String episodeDetails = '/episodeDetails';
  static const String home = '/';
  static const String search = '/search';
}
