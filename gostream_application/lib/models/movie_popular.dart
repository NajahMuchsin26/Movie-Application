class MoviePopular {
  final bool adult;
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final String MediaType;
  final double voteAverage;

  MoviePopular({
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

  factory MoviePopular.fromJson(Map<String, dynamic> json) {
    return MoviePopular(
      adult: json['adult'] ?? false,
      id: json['id'] ?? 0,
      title: json['known_for'][0]['title'] ?? '',
      overview: json['known_for'][0]['overview'] ?? '',
      posterPath: json['known_for'][0]['poster_path'] ?? '',
      backdropPath: json['known_for'][0]['backdrop_path'] ?? '',
      releaseDate: json['known_for'][0]['release_date'] ?? '',
      MediaType: json['known_for'][0]['media_type'] ?? '',
      voteAverage: json['known_for'][0]['vote_average']?.toDouble() ?? 0.0,
    );
  }
}
