// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:movie_app/description.dart';
import 'package:movie_app/utils/text.dart';

class TopRated extends StatelessWidget {
  final List topRated;
  const TopRated({super.key, required this.topRated});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModifiedText(
            text: 'Top Rated Movies',
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
              itemCount: topRated.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Description(
                            name: topRated[index]['title'],
                            description: topRated[index]['overview'],
                            bannerURL: 'http://image.tmdb.org/t/p/w500' +
                                topRated[index]['backdrop_path'],
                            posterURL: 'http://image.tmdb.org/t/p/w500' +
                                topRated[index]['poster_path'],
                            vote: topRated[index]['vote_average'].toString(),
                            launchOn: topRated[index]['release_date'],
                          );
                        },
                      ),
                    );
                  },
                  child: topRated[index]['title'] != null
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
                                            topRated[index]['poster_path']),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: ModifiedText(
                                    text: topRated[index]['title'],
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
