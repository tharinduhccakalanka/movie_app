import 'dart:convert';

import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movie.dart';
import 'package:http/http.dart' as http;

class MovieService {
  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=en-US&page=1'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'] as List;
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load popular movies: ${response.statusCode}');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    if (query.trim().isEmpty) return [];

    final response = await http.get(
      Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=${Uri.encodeComponent(query)}&page=1'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'] as List;
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Search failed: ${response.statusCode}');
    }
  }
}