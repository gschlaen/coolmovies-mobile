import 'dart:async';

import 'package:coolmovies/src/features/reviews/application/reviews_service.dart';
import 'package:coolmovies/src/features/reviews/data/reviews_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaveReviewController extends AutoDisposeAsyncNotifier<void> {
  bool mounted = true;

  @override
  FutureOr<void> build() {
    ref.onDispose(() => mounted = false);
  }

  Future<void> submitReview({
    required String movieId,
    required String title,
    required String body,
    required int rating,
  }) async {
    final reviewService = ref.read(reviewServiceProvider);
    state = const AsyncLoading();
    final newState =
        await AsyncValue.guard(() => throw Exception("Error Adrede"));
    // final newState = await AsyncValue.guard(() => reviewService.submitReview(
    //       movieId: movieId,
    //       title: title,
    //       body: body,
    //       rating: rating,
    //     ));

    if (mounted) {
      // * only set the state if the controller hasn´t been disposed
      state = newState;
      if (state is AsyncData) {
        // * invalidate the reviewsProvider to refetch the reviews
        ref.invalidate(reviewsProvider(movieId));
        ref.read(reviewsProvider(movieId));
      }
    }
  }
}

final leaveReviewControllerProvider =
    AsyncNotifierProvider.autoDispose<LeaveReviewController, void>(() {
  return LeaveReviewController();
});
