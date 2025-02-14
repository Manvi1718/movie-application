import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/top_rated.dart';
import 'package:movie_app/Widgets/trending.dart';
import 'package:movie_app/Widgets/tv.dart';
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
    });

    print(tv);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: ModifiedText(
          text: 'Movie App ❤️',
          color: Colors.white,
          size: 23,
        ),
        backgroundColor: const Color.fromARGB(255, 37, 37, 37),
      ),
      body: ListView(children: [
        TV(tv: tv),
        TopRated(topRated: topRatedMovies),
        TrendingMovies(trending: trendingMovies),
      ]),
    );
  }
}
