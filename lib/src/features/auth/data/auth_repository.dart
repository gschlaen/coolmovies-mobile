import 'package:coolmovies/src/features/auth/data/queries.dart';
import 'package:coolmovies/src/utils/graphql_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../domain/user.dart';

class AuthRepository {
  AuthRepository({required this.client});

  final GraphQLClient client;

  Future<User?> getCurrentUser() async {
    try {
      final result = await client.query(QueryOptions(
        document: gql(Queries.fetchCurrentUser),
        parserFn: (data) => User.fromMap(data['currentUser']),
      ));

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      return result.parsedData;
    } catch (e) {
      throw Exception(e);
    }
  }
}

final authRepositoryProvider = Provider.autoDispose<AuthRepository>((ref) {
  final client = ref.watch(graphQLClientProvider);
  return AuthRepository(client: client);
});

final currentUserProvider = FutureProvider.autoDispose<User?>((ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.getCurrentUser();
});
