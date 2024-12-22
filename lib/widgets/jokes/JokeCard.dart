import 'package:flutter/material.dart';
import '../../models/joke.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;
  final Future<void> Function(Joke) onPressed;

  const JokeCard({super.key, required this.joke, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              joke.type,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              joke.setup,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              joke.punchline,
              style: const TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            IconButton(onPressed: () => { onPressed(joke) }, icon: Icon(joke.isFavourite ? Icons.favorite : Icons.favorite_border_outlined), color: joke.isFavourite ? Colors.red : Colors.grey)
          ],
        ),
      ),
    );
  }
}
