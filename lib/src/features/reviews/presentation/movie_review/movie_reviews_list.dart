import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/error_message_widget.dart';
import '../../application/reviews_service.dart';
import '../../data/reviews_repository.dart';
import '../../domain/review.dart';
import '../delete_review/delete_review_controller.dart';
import 'movie_rating_bar.dart';

class MovieReviewsList extends ConsumerWidget {
  const MovieReviewsList({required this.movieId, super.key});

  final String movieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(reviewsProvider(movieId));

    // TODO: listen to state.hasError to show an error message
    return reviews.when(
      data: (reviews) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) =>
              MovieReviewCard(reviews[index], movieId),
          childCount: reviews.length,
        ),
      ),
      error: (e, st) =>
          SliverToBoxAdapter(child: ErrorMessageWidget(e.toString())),
      loading: () => const SliverToBoxAdapter(
          child: Padding(
        padding: EdgeInsets.only(top: 40),
        child: Center(child: CircularProgressIndicator()),
      )),
    );
  }
}

/// Simple card widget to show a movie review info (title, body, score)
class MovieReviewCard extends ConsumerWidget {
  const MovieReviewCard(this.review, this.movieId, {super.key});
  final Review review;
  final String movieId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userReview = ref.watch(userReviewProvider(movieId));
    final state = ref.watch(deleteReviewControllerProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MovieRatingBar(
                  initialRating: review.rating.toDouble(),
                  ignoreGestures: true,
                  itemSize: 20,
                  onRatingUpdate: (value) {},
                ),
                if (userReview.value?.userReviewerId == review.userReviewerId)
                  GestureDetector(
                    onTap: state.isLoading
                        ? null
                        : () => ref
                            .read(deleteReviewControllerProvider.notifier)
                            .deleteReview(
                                reviewId: review.id, movieId: movieId),
                    child: state.isLoading && state.value == review.id
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.delete, color: Colors.black45),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              review.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              review.body,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}
