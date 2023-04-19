import 'package:flutter/material.dart';
import '../models/coming_soon_model.dart';

import '../models/now_playing_model.dart';
import '../models/popular_model.dart';
import '../services/api_service.dart';
import '../widgets/make_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  Future<List<PopularModel>> popularMovies = ApiService.getPopularMovies();
  Future<List<NowPlayingModel>> nowPlayingMovies =
      ApiService.getNowPlayingMovies();
  Future<List<ComingSoonModel>> comingSoonMovies =
      ApiService.getCommingSoonMovies();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                'Popular Movies',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<List<PopularModel>>(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 180,
                      child: makePopularMovies(snapshot),
                    );
                  }
                  return const SizedBox(
                    height: 180,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Now in Cinemas',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<List<NowPlayingModel>>(
                future: nowPlayingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 110,
                      child: makeNowPlayingMovies(snapshot),
                    );
                  }
                  return const SizedBox(
                    height: 110,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Coming soon',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<List<ComingSoonModel>>(
                future: comingSoonMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 110,
                      child: makeComingSoonMovies(snapshot),
                    );
                  }
                  return const SizedBox(
                    height: 110,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
