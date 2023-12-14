import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:gostream_application/models/movie.dart';
import 'package:gostream_application/models/movie_popular.dart';
import 'package:gostream_application/models/movie_genre.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String apiKey = 'e7f7883240ba2a331b41549bb19d68b9';
  final String baseUrl = 'https://api.themoviedb.org/3/';

  Future<List<Movie>> _fetchMovies(String endpoint) async {
    final String uri = '$baseUrl$endpoint?api_key=$apiKey';

    try {
      final http.Response result = await http.get(Uri.parse(uri));

      if (result.statusCode == 200) {
        print("Success");
        final jsonResponse = json.decode(result.body);
        final movieMap = jsonResponse['results'];
        List<Movie> movies =
            List<Movie>.from(movieMap.map((i) => Movie.fromJson(i)));
        return movies;
      } else {
        print("Failed with status code: ${result.statusCode}");
        return [];
      }
    } catch (error) {
      print("Error: $error");
      return [];
    }
  }

  Future<List<MoviePopular>> _fetchMoviesPopular(String endpoint) async {
    final String uri = '$baseUrl$endpoint?api_key=$apiKey';

    try {
      final http.Response result = await http.get(Uri.parse(uri));

      if (result.statusCode == 200) {
        print("Success");
        final jsonResponse = json.decode(result.body);
        final List<dynamic> movieMap = jsonResponse['results'];

        List<MoviePopular> movies = List<MoviePopular>.from(
          movieMap.map((i) => MoviePopular.fromJson(i)),
        );
        // print("aaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        // print(movies[0].title);

        return movies;
      } else {
        print("Failed with status code: ${result.statusCode}");
        return [];
      }
    } catch (error) {
      print("Error: $error");
      return [];
    }
  }

  Future<List<MovieGenre>> _fetchMoviesGenre(
      String endpoint, String id_Genre) async {
    final String uri =
        '$baseUrl$endpoint?api_key=$apiKey&with_genres=$id_Genre';

    try {
      final http.Response result = await http.get(Uri.parse(uri));

      if (result.statusCode == 200) {
        print("Success");
        final jsonResponse = json.decode(result.body);
        final movieMap = jsonResponse['results'];
        List<MovieGenre> movies =
            List<MovieGenre>.from(movieMap.map((i) => MovieGenre.fromJson(i)));
        return movies;
      } else {
        print("Failed with status code: ${result.statusCode}");
        return [];
      }
    } catch (error) {
      print("Error: $error");
      return [];
    }
  }

  Future<List<MovieGenre>> _fetchMoviesAll(String endpoint) async {
    final String uri = '$baseUrl$endpoint?api_key=$apiKey';

    try {
      final http.Response result = await http.get(Uri.parse(uri));

      if (result.statusCode == 200) {
        print("Success");
        final jsonResponse = json.decode(result.body);
        final movieMap = jsonResponse['results'];
        List<MovieGenre> movies =
            List<MovieGenre>.from(movieMap.map((i) => MovieGenre.fromJson(i)));
        return movies;
      } else {
        print("Failed with status code: ${result.statusCode}");
        return [];
      }
    } catch (error) {
      print("Error: $error");
      return [];
    }
  }

  Future<List<Movie>> getTrendingMovies() async {
    return _fetchMovies('trending/movie/day');
  }

  Future<List<MoviePopular>> getPopularMovies() async {
    return _fetchMoviesPopular('person/popular');
  }

  Future<List<MovieGenre>> getRomanceMovies() async {
    return _fetchMoviesGenre('discover/movie', '10749');
  }

  Future<List<MovieGenre>> getActionMovies() async {
    return _fetchMoviesGenre('discover/movie', '28');
  }

  Future<List<MovieGenre>> getComedyMovies() async {
    return _fetchMoviesGenre('discover/movie', '35');
  }

  Future<List<MovieGenre>> getAllMovies() async {
    return _fetchMoviesAll('discover/movie');
  }
}
