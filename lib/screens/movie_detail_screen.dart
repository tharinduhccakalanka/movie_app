import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  
  const MovieDetailScreen({super.key, required this.movie});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: movie.backdropPath != null
                  ? CachedNetworkImage(
                      imageUrl: '$imageBaseUrl${movie.backdropPath}',
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: Colors.grey[850]),
                      errorWidget: (_, __, ___) => Container(color: Colors.grey[850]),
                    )
                  : Container(color: Colors.grey[850]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: 140,
                          child: CachedNetworkImage(
                            imageUrl: '$imageBaseUrl${movie.posterPath}',
                            fit: BoxFit.cover,
                            placeholder: (_, __) => Container(
                              height: 210,
                              color: Colors.grey[800],
                            ),
                            errorWidget: (_, __, ___) => Container(
                              height: 210,
                              color: Colors.grey[800],
                              child: const Icon(Icons.movie, size: 60),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                             movie.releaseDate?.substring(0,4) ?? "Unknown",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[400],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 28),
                                const SizedBox(width: 6),
                                Text(
                                  movie.voteAverage.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Overview',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    movie.overview?.isNotEmpty == true
                        ? movie.overview!
                        : 'No description available.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[300],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}