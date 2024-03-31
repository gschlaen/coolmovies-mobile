import 'package:coolmovies/src/features/movies/data/movies_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesListScreen extends ConsumerWidget {
  const MoviesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cool Movies'),
      ),
      body: Column(
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
                      // TODO: replace with a custom MovieListTile
                      return ListTile(
                        leading: Image(image: NetworkImage(movie.imgUrl)),
                        title: Text(movie.title),
                        subtitle: Text(movie.releaseDate.toString()),
                        onTap: () {},
                      );
                    },
                  ),
                  // TODO: improve error style
                  error: (e, st) => Center(child: Text(e.toString())),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
