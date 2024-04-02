import 'package:coolmovies/src/features/auth/data/auth_repository.dart';
import 'package:coolmovies/src/features/reviews/data/reviews_repository.dart';
import 'package:coolmovies/src/features/reviews/domain/review.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewService {
  ReviewService(this.ref);

  final Ref ref;

  Future<void> deleteReview({
    required String reviewId,
  }) async {
    final user = await ref.read(authRepositoryProvider).getCurrentUser();
    //* we should only call this method when the user is signed in
    assert(user != null);
    if (user == null) {
      throw AssertionError(
          'Can\'t delete a review if the user is not signed in');
    }
    await ref.read(reviewsRepositoryProvider).deleteReview(
          reviewId: reviewId,
        );
  }

  Future<void> submitReview({
    required String movieId,
    required String title,
    required String body,
    required int rating,
  }) async {
    final user = await ref.read(authRepositoryProvider).getCurrentUser();
    //* we should only call this method when the user is signed in
    assert(user != null);
    if (user == null) {
      throw AssertionError(
          'Can\'t delete a review if the user is not signed in');
    }
    await ref.read(reviewsRepositoryProvider).setReview(
          movieId: movieId,
          title: title,
          body: body,
          rating: rating,
          userReviewerId: user.id,
        );
  }
}

/// Check if a movie was previously reviewed by the user
final userReviewProvider =
    FutureProvider.autoDispose.family<Review?, String>((ref, movieId) async {
  final user = await ref.watch(authRepositoryProvider).getCurrentUser();
  if (user != null) {
    final reviews = ref.watch(reviewsProvider(movieId)).value;
    if (reviews != null) {
      try {
        return reviews.firstWhere((review) => review.userReviewerId == user.id);
      } catch (e) {
        //
      }
    }
  } else {
    return Future.value(null);
  }
  return null;
});

final reviewServiceProvider = Provider<ReviewService>((ref) {
  return ReviewService(ref);
});
