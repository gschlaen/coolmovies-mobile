import 'package:coolmovies/src/features/movies/domain/movie.dart';
import 'package:coolmovies/src/features/movies/presentation/movie_details/movie_details_screen.dart';
import 'package:coolmovies/src/features/movies/presentation/movies_list/movies_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home,
  movie,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/',
          name: AppRoute.home.name,
          pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: const MoviesListScreen(),
              ),
          routes: [
            GoRoute(
              path: ':id',
              name: AppRoute.movie.name,
              pageBuilder: (context, state) {
                final id = state.pathParameters['id'] as String;
                final movie = state.extra as Movie;
                return MaterialPage(
                  child: MovieDetailsScreen(movieId: id, movie: movie),
                );
              },
            )
          ]),
    ],
  );
});
