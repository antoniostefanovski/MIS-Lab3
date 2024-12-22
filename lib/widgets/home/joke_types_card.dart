import 'package:flutter/material.dart';

class JokeTypesCard extends StatelessWidget {
  final String jokeType;
  final VoidCallback onTap;

  const JokeTypesCard({
    super.key,
    required this.jokeType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(
          '$jokeType jokes',
          style: const TextStyle(fontSize: 18),
        ),
        leading: const Icon(Icons.tag_faces),
        onTap: onTap,
      ),
    );
  }
}
