import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/movie_detail_model.dart';
import '../services/api_service.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;

  const MovieDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<MovieDetailModel> movieDetail;

  @override
  void initState() {
    super.initState();
    movieDetail = ApiService.getMovieDetailById(widget.id);
  }

  String formatRuntime(int runtime) {
    int hours = runtime ~/ 60;
    int minutes = runtime % 60;
    return '${hours}h ${minutes}min' ?? '';
  }

  @override
  Widget build(BuildContext context) {
    // 기기에 따른 크기 설정
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: movieDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // 별 표시에 사용되는 변수
              final num voteAverage = snapshot.data!.voteAverage;
              final int fullStar = (voteAverage / 2).floor();
              final bool hasHalfStar = voteAverage % 2 >= 1;
              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      snapshot.data!.posterPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        title: const Text(
                          'Back to list',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: width * 0.05,
                    top: height * 0.32,
                    child: SizedBox(
                      width: width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              5,
                              (index) {
                                if (index < fullStar) {
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 20,
                                  );
                                } else if (index == fullStar && hasHalfStar) {
                                  return const Icon(
                                    Icons.star_half,
                                    color: Colors.yellow,
                                    size: 20,
                                  );
                                } else {
                                  return const Icon(Icons.star_border,
                                      color: Colors.yellow, size: 20);
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            children: [
                              Text(
                                '${formatRuntime(snapshot.data!.runtime)} |',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        snapshot.data!.genres.length, (index) {
                                      return Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          Text(
                                            snapshot.data!.genres[index]
                                                ['name'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.08,
                          ),
                          SizedBox(
                            height: height * 0.2,
                            width: width * 0.85,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Storyline',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Text(
                                  snapshot.data!.overview,
                                  softWrap: true,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.12,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                var url =
                                    'https://m.search.naver.com/search.naver?query=영화%20${snapshot.data!.title}&where=m&sm=mob_hty.idx&qdt=';
                                if (await canLaunchUrl(Uri.parse(url))) {
                                  await canLaunchUrl(Uri.parse(url));
                                } else {
                                  throw '인터넷 연결 상태를 확인해주세요.';
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                  color: const Color(0xff04CF5C),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Center(
                                  child: Text(
                                    '네이버 연결',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return Stack(
              children: const [
                Positioned.fill(
                    child: Center(
                  child: CircularProgressIndicator(),
                ))
              ],
            );
          },
        ),
      ),
    );
  }
}
