import 'package:coolmovies/src/features/movies/data/movie_director_repository.dart';
import 'package:coolmovies/src/features/movies/domain/movie.dart';
import 'package:coolmovies/src/features/reviews/data/reviews_repository.dart';
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
      body: ListView(
        children: [
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
                loading: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final reviews = ref.watch(reviewsProvider(movieId));
              return reviews.when(
                // TODO: improve UI
                data: (data) => Column(
                  children: data
                      .map((e) => ListTile(
                            leading: Text(e.rating.toString()),
                            title: Text(e.title),
                            subtitle: Text(e.body),
                            // TODO: Show only in user's review
                            trailing: GestureDetector(
                              child: const Icon(Icons.delete),
                              // TODO: Implement delete review
                              onTap: () {},
                            ),
                          ))
                      .toList(),
                ),
                // TODO: improve error style
                error: (e, st) => Text(e.toString()),
                loading: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ],
      ),
    );
  }
}
