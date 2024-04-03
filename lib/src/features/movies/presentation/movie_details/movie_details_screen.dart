import 'package:coolmovies/src/features/movies/domain/movie.dart';
import 'package:coolmovies/src/features/movies/presentation/movie_details/movie_details_list_tile.dart';
import 'package:coolmovies/src/features/reviews/application/reviews_service.dart';
import 'package:coolmovies/src/features/reviews/data/reviews_repository.dart';
import 'package:coolmovies/src/features/reviews/presentation/delete_review/delete_review_controller.dart';
import 'package:coolmovies/src/features/reviews/presentation/leave_review/leave_review_form.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: ListView(
          children: [
            MovieDetailsListTile(movie: movie),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final reviews = ref.watch(reviewsProvider(movieId));
                final userReview = ref.watch(userReviewProvider(movieId));
                final state = ref.watch(deleteReviewControllerProvider);
                // TODO: listen to state.hasError to show an error message
                return reviews.when(
                  // TODO: improve UI
                  data: (data) => Column(
                    children: data
                        .map((e) => ListTile(
                              leading: Text(e.rating.toString()),
                              title: Text(e.title),
                              subtitle: Text(e.body),
                              trailing: userReview.value?.userReviewerId ==
                                      e.userReviewerId
                                  ? GestureDetector(
                                      onTap: state.isLoading
                                          ? null
                                          : () => ref
                                              .read(
                                                  deleteReviewControllerProvider
                                                      .notifier)
                                              .deleteReview(
                                                  reviewId: e.id,
                                                  movieId: movieId),
                                      child: state.isLoading &&
                                              state.value == e.id
                                          ? const CircularProgressIndicator()
                                          : const Icon(Icons.delete),
                                    )
                                  : null,
                            ))
                        .toList(),
                  ),
                  // TODO: improve error style
                  error: (e, st) => Text(e.toString()),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final userReview = ref.watch(userReviewProvider(movieId));
                // * show the form only if the user hasn´t reviewed the movie
                if (userReview.value == null) {
                  return LeaveReviewForm(
                    movietId: movieId,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
