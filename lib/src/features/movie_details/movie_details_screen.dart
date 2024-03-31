import 'package:coolmovies/src/features/movies/domain/movie.dart';
import 'package:flutter/material.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen(
      {super.key, required this.movieId, required this.movie});

  final String movieId;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: const Center(
        child: Text('MovieDetailsScreen'),
      ),
    );
  }
}
