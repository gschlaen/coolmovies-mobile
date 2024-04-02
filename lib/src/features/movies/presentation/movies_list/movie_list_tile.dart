import 'package:flutter/material.dart';

import '../../../../common_widgets/movie_poster.dart';
import '../../domain/movie.dart';

class MovieListTile extends StatelessWidget {
  const MovieListTile({
    super.key,
    required this.movie,
    required this.onPressed,
  });
  final Movie movie;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            children: [
              SizedBox(
                width: MoviePoster.width,
                child: MoviePoster(imagePath: movie.imgUrl),
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
