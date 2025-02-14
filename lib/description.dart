// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';

class Description extends StatelessWidget {
  final String name;
  final String description;
  final String bannerURL;
  final String posterURL;
  final String vote;
  final String launchOn;

  const Description(
      {super.key,
      required this.name,
      required this.description,
      required this.bannerURL,
      required this.posterURL,
      required this.vote,
      required this.launchOn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        bannerURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 10,
                    child: ModifiedText(
                        text: 'Average Rating - ' + vote + ' ⭐',
                        color: const Color.fromARGB(255, 250, 246, 214),
                        size: 18),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ModifiedText(text: name, color: Colors.white, size: 27),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: ModifiedText(
                  text: 'Releasing On - ' + launchOn,
                  color: const Color.fromARGB(255, 147, 164, 198),
                  size: 15),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 200,
                  width: 100,
                  child: Image.network(posterURL),
                ),
                SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Container(
                    child: ModifiedText(
                        text: description,
                        color: const Color.fromARGB(255, 188, 188, 188),
                        size: 16),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
