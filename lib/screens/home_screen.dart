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
    // 기기에 따른 크기 설정
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              const Text(
                'Popular Movies',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              FutureBuilder<List<PopularModel>>(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: height * 0.3,
                      child: makePopularMovies(snapshot),
                    );
                  }
                  return SizedBox(
                    height: height * 0.3,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: height * 0.01,
              ),
              const Text(
                'Now in Cinemas',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              FutureBuilder<List<NowPlayingModel>>(
                future: nowPlayingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: height * 0.17,
                      child: makeNowPlayingMovies(snapshot),
                    );
                  }
                  return SizedBox(
                    height: height * 0.17,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: height * 0.01,
              ),
              const Text(
                'Coming soon',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              FutureBuilder<List<ComingSoonModel>>(
                future: comingSoonMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: height * 0.17,
                      child: makeComingSoonMovies(snapshot),
                    );
                  }
                  return SizedBox(
                    height: height * 0.17,
                    child: const Center(
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
