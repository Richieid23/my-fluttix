part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    final String url =
        'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=$page';

    client ??= http.Client();

    var response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List results = data['results'];

    return results.map((movie) => Movie.fromJson(movie)).toList();
  }
}
