import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common_widgets/movie_poster.dart';

class MovieListTileShimmer extends StatelessWidget {
  const MovieListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ShimmerItem(),
        ShimmerItem(),
        ShimmerItem(),
      ],
    );
  }
}

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Shimmer.fromColors(
          baseColor: Colors.black26,
          highlightColor: Colors.black12,
          child: Row(
            children: [
              Container(
                width: MoviePoster.width,
                height: MoviePoster.height,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 20.0,
                      color: Colors.black,
                      margin: const EdgeInsets.only(bottom: 8.0),
                    ),
                    Container(
                      width: 100.0,
                      height: 15.0,
                      color: Colors.black,
                    )
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
