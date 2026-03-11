import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_services.dart';
import 'package:movie_app/models/movie.dart';


class MovieProvider extends ChangeNotifier {
  final MovieService _service = MovieService();

  List<Movie> get filteredMovies => _filteredMovies;

  List<Movie> _movies = [];
  List<Movie> _filteredMovies = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Movie> get movies => _filteredMovies.isNotEmpty ? _filteredMovies : _movies;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPopularMovies() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _movies = await _service.getPopularMovies();
      _filteredMovies = [];
    } catch (e) {
      _errorMessage = 'Failed to load movies.\nCheck your internet connection.';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      _filteredMovies = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _filteredMovies = await _service.searchMovies(query);
      _errorMessage = _filteredMovies.isEmpty ? 'No movies found' : null;
    } catch (e) {
      _errorMessage = 'Search failed. Please try again.';
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearSearch() {
    _filteredMovies = [];
    _errorMessage = null;
    notifyListeners();
  }
}