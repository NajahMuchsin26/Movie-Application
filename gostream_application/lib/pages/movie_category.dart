import 'package:flutter/material.dart';
import 'package:gostream_application/models/movie_genre.dart';
import 'package:gostream_application/service/http_service.dart';
import 'package:gostream_application/models/movie.dart';
import 'package:gostream_application/pages/movie_detail.dart';

class category extends StatefulWidget {
  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {
  bool isLoading = true;
  late List moviesRomance;
  late List moviesAction;
  late List moviesComedy;
  late HttpService service;

  Future initialize() async {
    moviesRomance = await service.getRomanceMovies() as List;
    moviesAction = await service.getActionMovies() as List;
    moviesComedy = await service.getComedyMovies() as List;
    setState(() {
      isLoading = true; // Set loading to true when starting the data fetching
    });
    setState(() {
      moviesRomance = moviesRomance;
      moviesAction = moviesAction;
      moviesComedy = moviesComedy;
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
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          'CATEGORY',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CategoryGrid(
                        categoryName: 'Romance', movies: moviesRomance),
                    CategoryGrid(categoryName: 'Action', movies: moviesAction),
                    CategoryGrid(categoryName: 'Comedy', movies: moviesComedy),
                  ],
                ),
              ),
            ),
          );
  }
}

class CategoryGrid extends StatelessWidget {
  final String categoryName;
  final List movies;

  CategoryGrid({required this.categoryName, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryName.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, int position) {
                return MovieListItem(movies[position]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MovieListItem extends StatelessWidget {
  final MovieGenre movie;

  MovieListItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (_) => MovieDetail3(movie),
        );
        Navigator.push(context, route);
      },
      child: Container(
        width: 150,
        margin: EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 160,
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
