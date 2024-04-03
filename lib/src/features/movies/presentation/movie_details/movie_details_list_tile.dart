import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/movie_director_repository.dart';
import '../../domain/movie.dart';

class MovieDetailsListTile extends StatelessWidget {
  const MovieDetailsListTile({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        children: [
          Image(
            image: NetworkImage(movie.imgUrl),
            width: size.width * 0.45,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text('Released: ${movie.releaseDate}'),
                const SizedBox(height: 12),
                MovieDirectorWidget(movieDirectorId: movie.movieDirectorId),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MovieDirectorWidget extends ConsumerWidget {
  const MovieDirectorWidget({required this.movieDirectorId, super.key});

  final String movieDirectorId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDirector = ref.watch(movieDirectorProvider(movieDirectorId));

    return movieDirector.when(
      data: (data) => Text("Directed by\n${data.name} (${data.age})",
          style: Theme.of(context).textTheme.bodyLarge),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text(e.toString()),
    );
  }
}
