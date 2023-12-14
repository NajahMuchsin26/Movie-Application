import 'package:flutter/material.dart';
import 'package:gostream_application/models/movie_popular.dart';
import 'package:gostream_application/service/http_service.dart';
import 'package:gostream_application/models/movie.dart';
import 'package:gostream_application/pages/movie_detail.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  bool isLoading = true;
  late int moviesCount;
  late int topmoviesCount;
  late List movies;
  late List topmovies;
  late HttpService service;

  Future initialize() async {
    movies = [];
    movies = (await service.getTrendingMovies())!;
    topmovies = [];
    topmovies = (await service.getPopularMovies())!;
    setState(() {
      isLoading = true; // Set loading to true when starting the data fetching
    });
    setState(() {
      moviesCount = movies.length;
      topmoviesCount = topmovies.length;
      movies = movies;
      topmovies = topmovies;
      isLoading = false;
    });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "GoStream",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.redAccent.shade700,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: (topmoviesCount == null) ? 0 : topmoviesCount,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return MovieHeader(topmovies[index]);
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        enlargeCenterPage: true,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'TRENDING',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0.1,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: (moviesCount == null) ? 0 : moviesCount,
                      itemBuilder: (context, int position) {
                        return MovieListItem(movies[position]);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class MovieListItem extends StatelessWidget {
  final Movie movie;

  MovieListItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (_) => MovieDetail(movie),
        );
        Navigator.push(context, route);
      },
      child: Container(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              movie.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 14,
                ),
                Text(
                  movie.voteAverage.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MovieHeader extends StatelessWidget {
  final MoviePopular movie;

  MovieHeader(this.movie);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (_) => MovieDetail2(movie),
        );
        Navigator.push(context, route);
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            height: 150,
            width: 480,
            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
              width: 400,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            movie.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
