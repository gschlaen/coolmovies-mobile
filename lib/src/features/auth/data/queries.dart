abstract class Queries {
  static const String fetchCurrentUser = r"""
        query {
          currentUser {
            id
            name
          }
        }
      """;
}
