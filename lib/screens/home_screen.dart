import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import 'movie_detail_screen.dart';
import 'package:movie_app/widgets/search_bar.dart';
import 'package:movie_app/widgets/movie_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieProvider>().fetchPopularMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular Movies'), centerTitle: true),
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => provider.fetchPopularMovies(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final movies = provider.movies;

          if (movies.isEmpty && provider.errorMessage == null) {
            return const Center(
              child: Text(
                'No movies found',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          return Column(
            children: [
              SearchBarWidget(
                onSearch: (value) {
                  if (value.trim().isEmpty) {
                    provider.clearSearch();
                  } else {
                    provider.search(value);
                  }
                },
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await provider.fetchPopularMovies();
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.68,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return MovieCard(
                        movie: movie,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MovieDetailScreen(movie: movie),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
