// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:movie_app/description.dart';
import 'package:movie_app/utils/text.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;
  const TrendingMovies({super.key, required this.trending});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModifiedText(
            text: 'Trending Movies',
            size: 26,
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trending.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Description(
                            name: trending[index]['title'],
                            description: trending[index]['overview'],
                            bannerURL: 'http://image.tmdb.org/t/p/w500' +
                                trending[index]['backdrop_path'],
                            posterURL: 'http://image.tmdb.org/t/p/w500' +
                                trending[index]['poster_path'],
                            vote: trending[index]['vote_average'].toString(),
                            launchOn: trending[index]['release_date'],
                            isAdult: trending[index]['adult'],
                            originalLanguage: trending[index]
                                ['original_language'],
                            voteCount: trending[index]['vote_count'].toString(),
                          );
                        },
                      ),
                    );
                  },
                  child: trending[index]['title'] != null
                      ? Container(
                          width: 140,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'http://image.tmdb.org/t/p/w500' +
                                            trending[index]['poster_path']),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: ModifiedText(
                                    text: trending[index]['title'],
                                    color: Colors.grey,
                                    size: 15),
                              )
                            ],
                          ),
                        )
                      : Container(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
