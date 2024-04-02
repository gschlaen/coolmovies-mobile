import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({super.key, required this.imagePath});
  final String imagePath;

  static const width = 154.0;
  static const height = 231.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Image.network(
        imagePath,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Shimmer.fromColors(
            baseColor: Colors.black26,
            highlightColor: Colors.black12,
            child: Container(
              width: width,
              height: height,
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }
}
