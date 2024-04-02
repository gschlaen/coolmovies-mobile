import 'package:coolmovies/src/features/reviews/data/queries.dart';
import 'package:coolmovies/src/features/reviews/domain/review.dart';
import 'package:coolmovies/src/utils/graphql_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ReviewsRepository {
  ReviewsRepository({required this.client});

  final GraphQLClient client;

  Future<List<Review>> fetchReviewsByMovie({required String movieId}) async {
    try {
      final result = await client.query(QueryOptions(
        document: gql(Queries.fetchReviewsByMovie),
        variables: {'movieId': movieId},
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) => (data['allMovieReviews']['nodes'] as List)
            .map((e) => Review.fromMap(e))
            .toList(),
      ));
      if (result.hasException) {
        throw Exception(result.exception.toString());
      }
      return result.parsedData!;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteReview({required String reviewId}) async {
    try {
      final result = await client.mutate(
        MutationOptions(
          document: gql(Mutations.deleteReview),
          variables: {'reviewId': reviewId},
        ),
      );
      if (result.hasException) {
        throw Exception(result.exception.toString());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setReview({
    required String movieId,
    required String title,
    required String body,
    required int rating,
    required String userReviewerId,
  }) async {
    try {
      final result = await client.mutate(
        MutationOptions(
          document: gql(Mutations.setReview),
          variables: {
            'movieId': movieId,
            'title': title,
            'body': body,
            'rating': rating,
            'userReviewerId': userReviewerId
          },
        ),
      );
      if (result.hasException) {
        throw Exception(result.exception.toString());
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

final reviewsRepositoryProvider = AutoDisposeProvider<ReviewsRepository>((ref) {
  final client = ref.watch(graphQLClientProvider);
  return ReviewsRepository(client: client);
});

final reviewsProvider = AutoDisposeFutureProvider.family<List<Review>, String>(
    (ref, movieId) async {
  final reviewsRespository = ref.watch(reviewsRepositoryProvider);
  return reviewsRespository.fetchReviewsByMovie(movieId: movieId);
});
