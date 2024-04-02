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

  static const String setReview = r"""
        mutation SetReview($title: String!, $body: String!, $rating: Int!, $movieId: UUID!, $userReviewerId: UUID!){
          createMovieReview(input: {
            movieReview: {
              title: $title,
              body: $body,
              rating: $rating,
              movieId: $movieId,
              userReviewerId: $userReviewerId
            }}) {
          }
        }
      """;
}
