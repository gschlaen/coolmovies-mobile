import 'package:coolmovies/src/features/reviews/presentation/leave_review/leave_review_widget.dart';
import 'package:flutter/material.dart';

import '../../../reviews/presentation/movie_review/movie_reviews_list.dart';
import '../../domain/movie.dart';
import 'movie_details_list_tile.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen(
      {super.key, required this.movieId, required this.movie});

  final String movieId;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: CustomScrollView(
          slivers: [
            MovieDetailsListTile(movie: movie),
            MovieReviewsList(movieId: movie.id),
            LeaveReviewWidget(movieId: movieId),
          ],
        ),
      ),
    );
  }
}
