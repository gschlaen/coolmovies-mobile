import 'package:coolmovies/src/features/movies/data/queries.dart';
import 'package:coolmovies/src/features/movies/domain/movie_director.dart';
import 'package:coolmovies/src/utils/graphql_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MovieDirectorRepository {
  MovieDirectorRepository({required this.client});

  final GraphQLClient client;

  Future<MovieDirector> fetchMovieDirector({required String id}) async {
    try {
      final result = await client.query(QueryOptions(
        document: gql(Queries.fetchMovieDirector),
        variables: {'id': id},
      ));
      final movieDirector =
          MovieDirector.fromMap(result.data?['movieDirectorById']);
      return movieDirector;
    } catch (e) {
      throw Exception(e);
    }
  }
}

final movieDirectorRepositoryProvider =
    AutoDisposeProvider<MovieDirectorRepository>((ref) {
  final client = ref.watch(graphQLClientProvider);
  return MovieDirectorRepository(client: client);
});

final movieDirectorProvider =
    AutoDisposeFutureProvider.family<MovieDirector, String>((ref, id) async {
  final movieDirectorRespository = ref.watch(movieDirectorRepositoryProvider);
  return movieDirectorRespository.fetchMovieDirector(id: id);
});
