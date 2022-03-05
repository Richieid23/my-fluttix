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

  static Future<MovieDetail> getDetails(Movie movie,
      {int movieId, http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/${movieId ?? movie.id}?api_key=$apiKey&language=en-US';

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    List genres = (data as Map<String, dynamic>)['genres'];
    String language;

    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'ja':
        language = 'Japanese';
        break;
      case 'id':
        language = 'Indonesian';
        break;
      case 'ko':
        language = 'Korean';
        break;
      case 'en':
        language = 'English';
        break;
    }

    return movieId != null
        ? MovieDetail(
            movie: Movie.fromJson(data),
            language: language,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList())
        : MovieDetail(
            movie: movie,
            language: language,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList());
  }

  static Future<List<Credit>> getCredits(int movieId,
      {http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey';

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    return ((data as Map<String, dynamic>)['cast'] as List)
        .map((e) => Credit(
            name: (e as Map<String, dynamic>)['name'],
            profilePath: (e as Map<String, dynamic>)['profile_path']))
        .take(8)
        .toList();
  }
}
