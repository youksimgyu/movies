class MovieDetailModel {
  final int id;
  final String title;
  final List<Map<String, dynamic>> genres;
  final String overview;
  final String posterPath;
  final num voteAverage;
  final int runtime;

  MovieDetailModel.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        title = json['title'] ?? '',
        genres = List<Map<String, dynamic>>.from(json['genres'] ?? [])
            .map((genre) => {
                  'id': genre['id'],
                  'name': genre['name'],
                })
            .toList(),
        overview = json['overview'] ?? '',
        posterPath = 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
        voteAverage = json['vote_average'] ?? 0,
        runtime = json['runtime'] ?? 0;
}
