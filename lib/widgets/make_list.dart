import 'package:flutter/material.dart';

import '../models/coming_soon_model.dart';
import '../models/now_playing_model.dart';
import '../models/popular_model.dart';
import '../screens/movie_detail_screen.dart';

ListView makePopularMovies(AsyncSnapshot<List<PopularModel>> snapshot) {
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data!.length,
    itemBuilder: (context, index) {
      var popularMovie = snapshot.data![index];
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                id: popularMovie.id,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                popularMovie.backdropPath,
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                Text(
                  popularMovie.title,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
    separatorBuilder: (context, index) => const SizedBox(
      width: 10,
    ),
  );
}

ListView makeNowPlayingMovies(AsyncSnapshot<List<NowPlayingModel>> snapshot) {
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data!.length,
    itemBuilder: (context, index) {
      var nowPlayingMovie = snapshot.data![index];
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                id: nowPlayingMovie.id,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              width: 150,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                nowPlayingMovie.backdropPath,
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                Text(
                  nowPlayingMovie.title,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
    separatorBuilder: (context, index) => const SizedBox(
      width: 10,
    ),
  );
}

ListView makeComingSoonMovies(AsyncSnapshot<List<ComingSoonModel>> snapshot) {
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data!.length,
    itemBuilder: (context, index) {
      var comingMovie = snapshot.data![index];
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                id: comingMovie.id,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              width: 150,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                comingMovie.backdropPath,
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              comingMovie.title,
              style: const TextStyle(
                fontSize: 10,
              ),
            )
          ],
        ),
      );
    },
    separatorBuilder: (context, index) => const SizedBox(
      width: 10,
    ),
  );
}
