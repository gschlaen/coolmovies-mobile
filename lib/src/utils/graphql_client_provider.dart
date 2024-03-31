import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final graphQLClientProvider = AutoDisposeProvider<GraphQLClient>((ref) {
  final HttpLink httpLink = HttpLink(
    Platform.isAndroid
        ? 'http://10.0.2.2:5001/graphql'
        : 'http://localhost:5001/graphql',
  );

  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );
});
