// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/top_rated.dart';
import 'package:movie_app/Widgets/trending.dart';
import 'package:movie_app/Widgets/tv.dart';
import 'package:movie_app/description.dart';
import 'package:movie_app/utils/text.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingMovies = [];
  List topRatedMovies = [];
  List tv = [];
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic> movieMap = {};

  final String apiKey = 'f17f46ce4907bda0d1bc9e6d4b5abfe9';
  final String readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMTdmNDZjZTQ5MDdiZGEwZDFiYzllNmQ0YjVhYmZlOSIsIm5iZiI6MTczOTUyMTE1Ni4xMzUsInN1YiI6IjY3YWVmYzg0YTE4ZWJmMmFjNThlNWVjNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LkhLuo2WYlYb3pQaPB-No2kmrQZvf05yszwdhxjTJGM';

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingResult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topRatedResult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvResult = await tmdbWithCustomLogs.v3.tv.getPopular();

    setState(() {
      trendingMovies = trendingResult['results'];
      topRatedMovies = topRatedResult['results'];
      tv = tvResult['results'];
      print(tv[1]);
      _populateMovieMap();
    });
  }

  void _populateMovieMap() {
    movieMap.clear();
    for (var movie in trendingMovies + topRatedMovies + tv) {
      String? title = movie['title'] ?? movie['original_name'];
      if (title != null) {
        movieMap[title.toLowerCase()] = movie;
      }
    }
  }

  void _searchMovie(String movieName) {
    movieName = movieName.toLowerCase();

    if (movieMap.containsKey(movieName)) {
      var movie = movieMap[movieName];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Description(
              name: movie['title'] ?? movie['original_name'],
              description: movie['overview'] ?? 'No Description available',
              bannerURL: 'http://image.tmdb.org/t/p/w500' +
                  (movie['backdrop_path'] ?? ''),
              posterURL: 'http://image.tmdb.org/t/p/w500' +
                  (movie['poster_path'] ?? ''),
              vote: movie['vote_average'].toString(),
              launchOn: movie['release_date'] ?? movie['first_air_date'],
              isAdult: movie['adult'],
              originalLanguage: movie['original_language'],
              voteCount: movie['vote_count'].toString(),
            );
          },
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No movie found'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: ModifiedText(
          text: '🎭 MovieVerse',
          color: Colors.white,
          size: 23,
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search for a movie",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: _searchMovie,
            ),
          ),
          Expanded(
            child: ListView(children: [
              TV(tv: tv),
              TopRated(topRated: topRatedMovies),
              TrendingMovies(trending: trendingMovies),
            ]),
          ),
        ],
      ),
    );
  }
}
