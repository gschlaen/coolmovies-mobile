import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/error_message_widget.dart';
import '../../../../routing/app_router.dart';
import '../../data/movies_repository.dart';
import 'movie_list_tile.dart';
import 'movie_list_tile_shimmer.dart';

class MoviesListScreen extends StatelessWidget {
  const MoviesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cool Movies'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final movies = ref.watch(moviesListProvider);

                return movies.when(
                  data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final movie = data[index];
                      return MovieListTile(
                          movie: movie,
                          onPressed: () => context.goNamed(
                                AppRoute.movie.name,
                                pathParameters: {'id': movie.id.toString()},
                                extra: movie,
                              ));
                    },
                  ),
                  loading: () => const MovieListTileShimmer(),
                  error: (e, st) =>
                      Center(child: ErrorMessageWidget(e.toString())),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
