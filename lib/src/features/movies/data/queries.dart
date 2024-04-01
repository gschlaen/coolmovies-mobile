abstract class Queries {
  static const String fetchAllMovies = r"""
          query AllMovies {
            allMovies {
              nodes {
                id
                imgUrl
                movieDirectorId
                title
                releaseDate
              }
            }
          }
        """;

  static const String fetchMovieDirector = r"""
        query GetDirector($id: UUID!){
          movieDirectorById(id: $id) {
            id
            name
		        age
          }
        }
      """;
}
