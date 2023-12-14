import 'package:flutter/material.dart';
import 'package:gostream_application/models/movie_genre.dart';
import 'package:gostream_application/service/http_service.dart';
import 'package:gostream_application/models/movie.dart';
import 'package:gostream_application/pages/movie_detail.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MovieAll extends StatefulWidget {
  const MovieAll({Key? key}) : super(key: key);

  @override
  State<MovieAll> createState() => _MovieAllState();
}

class _MovieAllState extends State<MovieAll> {
  bool isLoading = true;
  late int moviesCount;
  late List movies;
  late List filteredMovies;
  late HttpService service;
  late TextEditingController searchController;
  bool hasInput = false;

  Future initialize() async {
    movies = [];
    movies = (await service.getAllMovies())!;
    setState(() {
      isLoading = true; // Set loading to true when starting the data fetching
    });
    setState(() {
      moviesCount = movies.length;
      movies = movies;
      filteredMovies = movies;
      isLoading = false;
    });
  }

  @override
  void initState() {
    service = HttpService();
    searchController = TextEditingController();
    initialize();
    searchController.addListener(() {
      setState(() {
        hasInput = searchController.text.isNotEmpty;
        filteredMovies = movies
            .where((movie) => movie.title
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
            .toList();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      hasInput = value.isNotEmpty;
                      filteredMovies = movies
                          .where((movie) => movie.title
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search movies...',
                    hintStyle:
                        TextStyle(color: Colors.white), // Set hint text color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.black, // Set background color
                    contentPadding:
                        EdgeInsets.all(12.0), // Adjust content padding
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    // Add a subtle shadow
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                      gapPadding: 5.0,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                      gapPadding: 5.0,
                    ),
                  ),
                  style:
                      TextStyle(color: hasInput ? Colors.white : Colors.black),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ALL MOVIES',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0.1,
                        mainAxisSpacing: 10,
                      ),
                      itemCount:
                          (filteredMovies == null) ? 0 : filteredMovies.length,
                      itemBuilder: (context, int position) {
                        return MovieAllItem(filteredMovies[position]);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieAllItem extends StatelessWidget {
  final MovieGenre movie;

  MovieAllItem(this.movie);

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
