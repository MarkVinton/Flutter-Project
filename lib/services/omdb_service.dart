import 'dart:convert';
import 'package:http/http.dart' as http;

class OmdbService {
  final String apiKey = '2fd4ab24';

  Future<List<dynamic>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse('http://www.omdbapi.com/?s=$query&apikey=$apiKey'),
    );
    print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['Search'] ?? [];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<Map<String, dynamic>> getMovieDetails(String imdbID) async {
    final response = await http.get(
      Uri.parse('http://www.omdbapi.com/?i=$imdbID&apikey=$apiKey'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
