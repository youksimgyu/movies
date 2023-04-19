class PopularModel {
  final int id;
  final String title;
  final String backdropPath;

  PopularModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        title = json['title'] ?? '',
        backdropPath =
            'https://image.tmdb.org/t/p/w500${json['backdrop_path']}';
}
