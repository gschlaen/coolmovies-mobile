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
