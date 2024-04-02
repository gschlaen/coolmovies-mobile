abstract class Queries {
  static const String fetchReviewsByMovie = r"""
        query GetReviews($movieId: UUID!){
          allMovieReviews(
            filter: {movieId: {equalTo: $movieId}}
          ) {
            nodes {
	        		id
              title
              body
              rating
	        		userReviewerId
            }
          }
      }
      """;
}

abstract class Mutations {
  static const String deleteReview = r"""
        mutation DeleteReview($reviewId: UUID!){
          deleteMovieReviewById(input: {id: $reviewId}) {
          }
        }
      """;
}
