import 'package:coolmovies/src/features/auth/data/auth_repository.dart';
import 'package:coolmovies/src/features/reviews/data/reviews_repository.dart';
import 'package:coolmovies/src/features/reviews/domain/review.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
