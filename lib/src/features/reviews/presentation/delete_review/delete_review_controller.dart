import 'dart:async';

import 'package:coolmovies/src/features/reviews/application/reviews_service.dart';
import 'package:coolmovies/src/features/reviews/data/reviews_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteReviewController extends AutoDisposeAsyncNotifier<String?> {
  bool mounted = true;

  @override
  FutureOr<String?> build() {
    ref.onDispose(() => mounted = false);
    return null;
  }

  Future<void> deleteReview(
      {required String reviewId, required String movieId}) async {
    final reviewService = ref.read(reviewServiceProvider);
    state = AsyncData(reviewId);
    state = const AsyncLoading<String?>().copyWithPrevious(state);
    final newState = await AsyncValue.guard(
        () => reviewService.deleteReview(reviewId: reviewId));

    if (mounted) {
      // * only set the state if the controller hasn´t been disposed
      if (newState.hasError) {
        state = AsyncError(newState.error!, StackTrace.current);
      } else {
        state = const AsyncData(null);
        // * invalidate the reviewsProvider to refetch the reviews
        ref.invalidate(reviewsProvider(movieId));
        ref.read(reviewsProvider(movieId));
      }
    }
  }
}

final deleteReviewControllerProvider =
    AsyncNotifierProvider.autoDispose<DeleteReviewController, String?>(() {
  return DeleteReviewController();
});
