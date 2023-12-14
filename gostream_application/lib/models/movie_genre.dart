class MovieGenre {
  final bool adult;
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final String MediaType;
  final double voteAverage;

  MovieGenre({
    required this.adult,
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.MediaType,
    required this.voteAverage,
  });

  factory MovieGenre.fromJson(Map<String, dynamic> json) {
    return MovieGenre(
      adult: json['adult'] ?? false,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      MediaType: json['media_type'] ?? '',
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
    );
  }
}
