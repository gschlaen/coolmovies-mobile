import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/reviews_service.dart';
import '../../data/reviews_repository.dart';
import 'leave_review_form.dart';

class LeaveReviewWidget extends ConsumerWidget {
  const LeaveReviewWidget({
    super.key,
    required this.movieId,
  });

  final String movieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userReview = ref.watch(userReviewProvider(movieId));
    final reviews = ref.watch(reviewsProvider(movieId));

    return SliverToBoxAdapter(
      child:
          // * show the form only if the user hasn´t reviewed the movie
          userReview.value == null && !reviews.isLoading
              ? LeaveReviewForm(
                  movietId: movieId,
                )
              : const SizedBox.shrink(),
    );
  }
}
