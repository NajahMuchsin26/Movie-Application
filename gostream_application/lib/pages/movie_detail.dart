import 'package:flutter/material.dart';
import 'package:gostream_application/models/movie.dart';
import 'package:gostream_application/models/movie_genre.dart';
import 'package:gostream_application/models/movie_popular.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  final String imgPath = 'https://image.tmdb.org/t/p/w500';

  MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    String path;
    String bdPath;

    if (movie.posterPath != null) {
      path = imgPath + movie.posterPath;
    } else {
      path =
          'https://images.freeimages.com/images/large-previews/5eb/movue-clapboard-1184339.jpg';
    }

    if (movie.posterPath != null) {
      bdPath = imgPath + movie.bdPath;
    } else {
      bdPath =
          'https://images.freeimages.com/images/large-previews/5eb/movue-clapboard-1184339.jpg';
    }
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: Stack(
        children: [
          // Bagian atas dengan gambar horizontal 1/4 bagian atas
          movieHeader(backdropPath: bdPath),
          ListView(
            children: [
              SizedBox(height: 1),
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              MovieInfoRow(
                title: movie.title,
                year: movie.year.toString(),
                genre: movie.type,
                imgPath: path,
                rating: movie.voteAverage,
              ),
              SizedBox(height: 10),
              MovieSinopsis(overview: movie.overview),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class MovieDetail2 extends StatelessWidget {
  final MoviePopular movie;
  final String imgPath = 'https://image.tmdb.org/t/p/w500';

  MovieDetail2(this.movie);

  @override
  Widget build(BuildContext context) {
    String path;
    String bdPath;

    if (movie.posterPath != null) {
      path = imgPath + movie.posterPath;
    } else {
      path =
          'https://images.freeimages.com/images/large-previews/5eb/movue-clapboard-1184339.jpg';
    }

    if (movie.posterPath != null) {
      bdPath = imgPath + movie.backdropPath;
    } else {
      bdPath =
          'https://images.freeimages.com/images/large-previews/5eb/movue-clapboard-1184339.jpg';
    }
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: Stack(
        children: [
          // Bagian atas dengan gambar horizontal 1/4 bagian atas
          movieHeader(backdropPath: bdPath),
          ListView(
            children: [
              SizedBox(height: 1),
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              MovieInfoRow(
                title: movie.title,
                year: movie.releaseDate,
                genre: movie.MediaType,
                imgPath: path,
                rating: movie.voteAverage,
              ),
              SizedBox(height: 10),
              MovieSinopsis(overview: movie.overview),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class MovieDetail3 extends StatelessWidget {
  final MovieGenre movie;
  final String imgPath = 'https://image.tmdb.org/t/p/w500';

  MovieDetail3(this.movie);

  @override
  Widget build(BuildContext context) {
    String path;
    String bdPath;

    if (movie.posterPath != null) {
      path = imgPath + movie.posterPath;
    } else {
      path =
          'https://images.freeimages.com/images/large-previews/5eb/movue-clapboard-1184339.jpg';
    }

    if (movie.posterPath != null) {
      bdPath = imgPath + movie.backdropPath;
    } else {
      bdPath =
          'https://images.freeimages.com/images/large-previews/5eb/movue-clapboard-1184339.jpg';
    }
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: Stack(
        children: [
          // Bagian atas dengan gambar horizontal 1/4 bagian atas
          movieHeader(backdropPath: bdPath),
          ListView(
            children: [
              SizedBox(height: 1),
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              MovieInfoRow(
                title: movie.title,
                year: movie.releaseDate,
                genre: 'Movie',
                imgPath: path,
                rating: movie.voteAverage,
              ),
              SizedBox(height: 10),
              MovieSinopsis(overview: movie.overview),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class movieHeader extends StatelessWidget {
  final String backdropPath;

  movieHeader({
    required this.backdropPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            backdropPath,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MovieInfoRow extends StatelessWidget {
  final String title;
  final String imgPath;
  final String year;
  final String genre;
  final double rating;

  MovieInfoRow({
    required this.title,
    required this.year,
    required this.genre,
    required this.imgPath,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          imgPath,
          width: 150,
          height: 200,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildInfoRow("JUDUL", title),
            SizedBox(height: 10),
            _buildInfoRow("TAHUN", year),
            SizedBox(height: 10),
            _buildInfoRow("TYPE", genre),
            SizedBox(height: 10),
            _buildRatingRow("RATING", rating),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Container(
          width: 60,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 5), // Spacer
        Container(
          width: 100,
          child: Text(
            ': $value',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingRow(String label, double rating) {
    return Row(
      children: [
        Container(
          width: 65,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          ':',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Container(
          child: Icon(
            Icons.star,
            color: Colors.yellow,
            size: 18,
          ),
        ),
        Text(
          rating.toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class MovieSinopsis extends StatelessWidget {
  final String overview;

  MovieSinopsis({
    required this.overview,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SINOPSIS',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Text(
          overview,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
