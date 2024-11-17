import 'package:flutter/material.dart';
import '../services/omdb_service.dart';

class MovieDetailScreen extends StatelessWidget {
  final String imdbID;
  final OmdbService _omdbService = OmdbService();

  MovieDetailScreen(this.imdbID, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _omdbService.getMovieDetails(imdbID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading details'));
          } else {
            final movie = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie['Title'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text('Year: ${movie['Year']}'),
                  Text('Rated: ${movie['Rated']}'),
                  Text('Released: ${movie['Released']}'),
                  const SizedBox(height: 10),
                  Text(movie['Plot'] ?? 'No plot available'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
