class Movie {
  int id = 0;
  String title = "";
  double voteAverage = 0.0;
  String overview = "";
  String posterPath = "";
  String bdPath = "";
  String year = "";
  String type = "";

  Movie(this.id, this.title, this.voteAverage, this.overview, this.posterPath,
      this.bdPath, this.year, this.type);

  Movie.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.title = parsedJson['title'];
    this.voteAverage = parsedJson['vote_average'] * 1.0;
    this.overview = parsedJson['overview'];
    this.posterPath = parsedJson['poster_path'];
    this.bdPath = parsedJson['backdrop_path'];
    this.year = parsedJson['release_date'];
    this.type = parsedJson['media_type'];
  }
}
