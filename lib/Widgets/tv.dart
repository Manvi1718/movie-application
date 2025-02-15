// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:movie_app/description.dart';
import 'package:movie_app/utils/text.dart';

class TV extends StatelessWidget {
  final List tv;
  const TV({super.key, required this.tv});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModifiedText(
            text: 'Popular TV Shows',
            size: 26,
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tv.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Description(
                            name: tv[index]['original_name'],
                            description: tv[index]['overview'],
                            bannerURL: 'http://image.tmdb.org/t/p/w500' +
                                tv[index]['backdrop_path'],
                            posterURL: 'http://image.tmdb.org/t/p/w500' +
                                tv[index]['poster_path'],
                            vote: tv[index]['vote_average'].toString(),
                            launchOn: tv[index]['first_air_date'],
                            isAdult: tv[index]['adult'],
                            originalLanguage: tv[index]['original_language'],
                            voteCount: tv[index]['vote_count'].toString(),
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: 250,
                    child: Column(
                      children: [
                        Container(
                          width: 250,
                          height: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'http://image.tmdb.org/t/p/w500' +
                                      tv[index]['backdrop_path']),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: ModifiedText(
                              text: tv[index]['original_name'] ?? 'loading',
                              color: Colors.grey,
                              size: 15),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
