import 'package:coolmovies/src/features/movies/data/queries.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../utils/graphql_client_provider.dart';
import '../domain/movie.dart';

class MoviesRepository {
  MoviesRepository({required this.client});
  final GraphQLClient client;

  Future<List<Movie>> fetchAllMovies() async {
    try {
      final result = await client.query(QueryOptions(
        document: gql(Queries.fetchAllMovies),
      ));
      final movies = (result.data?['allMovies']['nodes'] as List<dynamic>)
          .map((e) => Movie.fromMap(e))
          .toList();
      return movies;
    } catch (e) {
      throw Exception(e);
    }
  }
}

final moviesRepositoryProvider = AutoDisposeProvider<MoviesRepository>((ref) {
  final client = ref.watch(graphQLClientProvider);
  return MoviesRepository(client: client);
});

final moviesListProvider = AutoDisposeFutureProvider<List<Movie>>((ref) async {
  final moviesRespository = ref.watch(moviesRepositoryProvider);
  return moviesRespository.fetchAllMovies();
});
