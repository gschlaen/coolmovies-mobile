import 'package:coolmovies/src/features/movies/data/movie_director_repository.dart';
import 'package:coolmovies/src/features/movies/domain/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen(
      {super.key, required this.movieId, required this.movie});

  final String movieId;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      // TODO: improve UI
      body: ListView(children: [
        Image(image: NetworkImage(movie.imgUrl)),
        Text(movie.releaseDate),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final movieDirector =
                ref.watch(movieDirectorProvider(movie.movieDirectorId));
            return movieDirector.when(
              data: (data) => Text("${data.name} (${data.age})"),
              // TODO: improve error style
              error: (e, st) => Text(e.toString()),
              loading: () => const CircularProgressIndicator(),
            );
          },
        ),
      ]),
    );
  }
}
